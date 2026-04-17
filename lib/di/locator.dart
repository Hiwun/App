
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/storage/storage.dart';

import '../features/auth/auth.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookiesPath = '${appDocDir.path}/.cookies/';
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
  ));

  getIt.registerLazySingleton<CookieJar>(() => PersistCookieJar(
    storage: FileStorage(cookiesPath)
  ));
  getIt.registerLazySingletonAsync<TokenStorage>(() async {
    final storage = TokenStorage(getIt());
    await storage.init();

    return storage;
  });
  getIt.registerLazySingleton<UserStorage>(() => UserStorage());

  await getIt.isReady<TokenStorage>();

  getIt.registerLazySingleton<AuthService>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://auth.uniquiq.ru'));
    final jar = getIt<CookieJar>();
    dio.interceptors.add(CookieManager(jar));
    return AuthService(dio, getIt<TokenStorage>(), getIt<UserStorage>());
  });
  final tokenStorage = getIt<TokenStorage>();
  var tokenIsNull = await tokenStorage.isNull();
  var tokenExpired = await tokenStorage.isExpired();

  if(!tokenIsNull && !tokenExpired) {
    await getIt<AuthService>().currentUser();


    // Добавляем копирование куки из auth в backend после успешного currentUser()
    final jar = getIt<CookieJar>();
    final authUri = Uri.parse('https://auth.uniquiq.ru/');
    final cookies = await jar.loadForRequest(authUri);

    if (cookies.isNotEmpty) {
      final backendUri = Uri.parse('https://backend.uniquiq.ru/');
      await jar.saveFromResponse(backendUri, cookies);
    }
  } else if(!tokenIsNull && tokenExpired){

    await getIt<AuthService>().refresh();
    await getIt<AuthService>().currentUser();


    // Добавляем копирование куки из auth в backend после успешного currentUser()
    final jar = getIt<CookieJar>();
    final authUri = Uri.parse('https://auth.uniquiq.ru/');
    final cookies = await jar.loadForRequest(authUri);

    if (cookies.isNotEmpty) {
      final backendUri = Uri.parse('https://backend.uniquiq.ru/');
      await jar.saveFromResponse(backendUri, cookies);
    }

    tokenIsNull = await tokenStorage.isNull();
    tokenExpired = await tokenStorage.isExpired();
  }
  final userStorage = getIt<UserStorage>();

  getIt.registerLazySingleton<AuthBloc>(() =>
      AuthBloc(isLoggedIn: !tokenIsNull && !tokenExpired && userStorage.user != null)
  );

  //getIt.registerLazySingleton<AuthInterceptor>(() => AuthInterceptor(getIt(), getIt()));
  getIt.registerLazySingleton<Dio>(() {
    final jar = getIt<CookieJar>();

    final dio = Dio(BaseOptions(baseUrl: 'https://backend.uniquiq.ru'));
    dio.interceptors.add(CookieManager(jar));
    //dio.interceptors.add(getIt<AuthInterceptor>());
    return dio;
  });

  getIt.registerFactory<BookingService>(() => BookingService(dio: getIt()));
  getIt.registerFactory<VenueService>(() => VenueService(dio: getIt()));
  getIt.registerFactory<NotificationService>(() => NotificationService(dio: getIt()));
  getIt.registerFactory<PromotionService>(() => PromotionService(dio: getIt()));
  getIt.registerFactory<ActionService>(() => ActionService(dio: getIt()));
  getIt.registerFactory<ActivityService>(() => ActivityService(dio: getIt()));
  getIt.registerFactory<NeedService>(() => NeedService(dio: getIt()));
  getIt.registerFactory<PropertyService>(() => PropertyService(dio: getIt()));
  getIt.registerFactory<FileService>(() => FileService(dio: getIt()));
  getIt.registerFactory<CompanyService>(() => CompanyService(dio: getIt()));
  getIt.registerFactory<ContactService>(() => ContactService(dio: getIt()));
  getIt.registerLazySingleton<PropertyFilterStorage>(() => PropertyFilterStorage.initial());
}