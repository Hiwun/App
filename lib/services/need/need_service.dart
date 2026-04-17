import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class NeedService{
  final Dio dio;

  NeedService({required this.dio});

  Future<ApiResponse<Need?>> getNeedByGuid(UuidValue guid) async {
    try{
      final response = await dio.get(
          '/api/realty/need/get/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Need?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Need.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiPaginationResponse<List<Need>>> getNeedList(int offset, limit) async {
    try{
      final Map<String, dynamic> parameters = {
        "offset": offset,
        "limit": limit
      };

      final response = await dio.post(
          '/api/realty/need/list',
          options: Options(contentType: Headers.jsonContentType),
          queryParameters: parameters
      );

      return ApiPaginationResponse<List<Need>>.fromJson(response.data, (data){
        if (data is List) {
          List<Need> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Need.fromJson(item))
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
  Future<void> createNeed(Need model) async {
    try{
      await dio.post(
          '/api/realty/need/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> updateNeed(Need model) async {
    try{
      await dio.post(
          '/api/realty/need/update',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> deleteNeed(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/need/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
}