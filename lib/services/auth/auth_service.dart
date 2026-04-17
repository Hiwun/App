
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/storage/storage.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final Dio dio;
  final TokenStorage storage;
  final UserStorage userStorage;

  AuthService(this.dio, this.storage, this.userStorage);

  Future<void> login(String user, String pass) async {
    try{
      final response = await dio.post(
          '/auth/login',
          data: {
            'username': user,
            'password': pass
          },
          options: Options(contentType: Headers.jsonContentType)
      );
      final token = response.data['access_token'] as String;
      storage.saveToken(token);
    } on DioException catch (e){
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print('Не удалось подключиться к серверу');
          break;
        case DioExceptionType.receiveTimeout:
          print('Сервер слишком долго не отвечает');
          break;
        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          if (status == 401) {
            print('Unauthorized — токен истёк или неверен');
          } else if (status == 400) {
            print('Bad request: ${e.response?.data}');
          } else {
            print('Ошибка $status: ${e.response?.data}');
          }
          break;
        case DioExceptionType.cancel:
          print('Запрос был отменён');
          break;
        case DioExceptionType.unknown:
          print('Неизвестная ошибка: ${e.message}');
          break;
        default:
          print('Другая ошибка: ${e.message}');
      }
      rethrow;
    } catch (e){
      print('Unexpected error: $e');
      rethrow;
    }
  }
  Future<AuthPhoneResponse> loginPhone(String phone) async {
    try{
      final response = await dio.post(
          '/api/auth/login/phone',
          data: {
            'phone': phone,
          },
          options: Options(contentType: Headers.jsonContentType)
      );

      return AuthPhoneResponse.fromJson(response.data);
    } on DioException catch (e){
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print('Не удалось подключиться к серверу');
          break;
        case DioExceptionType.receiveTimeout:
          print('Сервер слишком долго не отвечает');
          break;
        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          if (status == 401) {
            print('Unauthorized — токен истёк или неверен');
          } else if (status == 400) {
            print('Bad request: ${e.response?.data}');
          } else {
            print('Ошибка $status: ${e.response?.data}');
          }
          break;
        case DioExceptionType.cancel:
          print('Запрос был отменён');
          break;
        case DioExceptionType.unknown:
          print('Неизвестная ошибка: ${e.message}');
          break;
        default:
          print('Другая ошибка: ${e.message}');
      }
      rethrow;
    } catch (e){
      print('Unexpected error: $e');
      rethrow;
    }
  }
  Future<void> checkCodePhone(UuidValue? userGUID, int code) async {
    try{
      final response = await dio.post(
          '/api/auth/login/check',
          data: {
            'user_guid': userGUID.toString(),
            'code': code,
          },
          options: Options(contentType: Headers.jsonContentType)
      );
      final token = response.data['access_token'] as String;
      storage.saveToken(token);

      // Добавляем копирование куки из auth в backend после успешного currentUser()
      final jar = getIt<CookieJar>();
      final authUri = Uri.parse('https://auth.uniquiq.ru/');
      final cookies = await jar.loadForRequest(authUri);

      if (cookies.isNotEmpty) {
        final backendUri = Uri.parse('https://backend.uniquiq.ru/');
        await jar.saveFromResponse(backendUri, cookies);
      }

    } on DioException catch (e){
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          print('Не удалось подключиться к серверу');
          break;
        case DioExceptionType.receiveTimeout:
          print('Сервер слишком долго не отвечает');
          break;
        case DioExceptionType.badResponse:
          final status = e.response?.statusCode;
          if (status == 401) {
            print('Unauthorized — токен истёк или неверен');
          } else if (status == 400) {
            print('Bad request: ${e.response?.data}');
          } else {
            print('Ошибка $status: ${e.response?.data}');
          }
          break;
        case DioExceptionType.cancel:
          print('Запрос был отменён');
          break;
        case DioExceptionType.unknown:
          print('Неизвестная ошибка: ${e.message}');
          break;
        default:
          print('Другая ошибка: ${e.message}');
      }
      rethrow;
    } catch (e){
      print('Unexpected error: $e');
      rethrow;
    }
  }
  Future<void> refresh() async {
    try{
      final response = await dio.get('/api/auth/check');

      // Получаем cookies из заголовков ответа
      final cookies = response.headers['set-cookie'];

      if (cookies != null) {
        // Ищем access_token cookie
        final accessToken = _extractAccessTokenFromCookies(cookies);

        if (accessToken != null) {
          storage.saveToken(accessToken);
        } else {
          storage.clear();
        }
      } else {
        storage.clear();
      }
    } catch (e){
      rethrow;
    }

  }

  String? _extractAccessTokenFromCookies(List<String> cookies) {
    for (final cookie in cookies) {
      if (cookie.contains('access_token')) {
        // Извлекаем значение access_token из cookie
        final pattern = RegExp(r'access_token=([^;]+)');
        final match = pattern.firstMatch(cookie);
        if (match != null) {
          return match.group(1);
        }
      }
    }
    return null;
  }

  Future<void> currentUser() async {
    try{
      final response = await dio.get('/api/user/current', options: Options(
        headers: {
          "Authorization": 'Bearer ${storage.token}'
        }
      ));

      final user = User.fromJson(response.data);
      userStorage.update(user);
    } catch (e){
      rethrow;
    }

  }
  Future<void> revoke() async {
    try{
      await dio.get('/auth/revoke');
      storage.clear();
    } catch (e){
      rethrow;
    }
  }
}