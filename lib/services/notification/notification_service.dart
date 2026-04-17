

import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';

class NotificationService{
  final Dio dio;

  NotificationService({required this.dio});




  Future<ApiPaginationResponse<List<NotificationModel>>> getUserNotifications(int offset, limit) async {
    try{
      final response = await dio.post(
          '/api/restorator/notification/list?offset=$offset&limit=$limit',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<NotificationModel>>.fromJson(response.data, (data){
        if (data is List) {
          List<NotificationModel> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => NotificationModel.fromJson(item))
              .toList();
          return items;
        } else {
          return []; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
}