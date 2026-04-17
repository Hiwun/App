import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class ActivityService{
  final Dio dio;

  ActivityService({required this.dio});

  Future<ApiPaginationResponse<List<Activity>>> getActivitiesList(int offset, limit, String entityType, UuidValue entityGuid) async {
    try{
      final Map<String, dynamic> parameters = {
        "offset": offset,
        "limit": limit
      };

      final response = await dio.post(
          '/api/realty/activity/list/$entityType/${entityGuid.uuid}',
          options: Options(contentType: Headers.jsonContentType),
          queryParameters: parameters
      );

      return ApiPaginationResponse<List<Activity>>.fromJson(response.data, (data){
        if (data is List) {
          List<Activity> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Activity.fromJson(item))
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
  Future<void> deleteActivity(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/activity/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> createActivity(Activity model) async {
    try{
      await dio.post(
          '/api/realty/activity/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
}