import 'package:dio/dio.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/storage/storage.dart';

class AuthInterceptor extends Interceptor{
  final TokenStorage storage;
  final AuthService authService;

  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  AuthInterceptor(this.storage, this.authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storage.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if(err.response?.statusCode == 401){
      final originalRequest = err.requestOptions;

      if(!_isRefreshing){
        _isRefreshing = true;

        try{
          await authService.refresh();
          final newToken = storage.token;

          _isRefreshing = false;

          for (final retry in _retryQueue){
            retry();
          }

          _retryQueue.clear();

          originalRequest.headers['Authorization'] = 'Bearer $newToken';
          final response = await getIt<Dio>().fetch(originalRequest);
          handler.resolve(response);
        } catch (e){
          _isRefreshing = false;
          _retryQueue.clear();
          return handler.reject(err);
        }
      } else {
        _retryQueue.add(() async {
          final newToken = storage.token;
          if(newToken != null){
            originalRequest.headers['Authorization'] = 'Bearer $newToken';
            final response = await getIt<Dio>().fetch(originalRequest);
            handler.resolve(response);
          } else {
            handler.reject(err);
          }
        });
      }
    } else {
      handler.next(err);
    }
  }
}