import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class ActionService{
  final Dio dio;

  ActionService({required this.dio});

  Future<ApiResponse<Action?>> getActionByGuid(UuidValue guid) async {
    try{
      final response = await dio.get(
          '/api/realty/action/get/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Action?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Action.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiPaginationResponse<List<Action>>> getActionList(int offset, limit) async {
    try{
      final Map<String, dynamic> parameters = {
        "offset": offset,
        "limit": limit
      };

      final response = await dio.post(
          '/api/realty/action/list',
          options: Options(contentType: Headers.jsonContentType),
          queryParameters: parameters
      );

      return ApiPaginationResponse<List<Action>>.fromJson(response.data, (data){
        if (data is List) {
          List<Action> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Action.fromJson(item))
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
  Future<void> createAction(Action model) async {
    try{
      await dio.post(
          '/api/realty/action/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> updateAction(Action model) async {
    try{
      await dio.post(
          '/api/realty/action/update',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> deleteAction(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/action/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
}