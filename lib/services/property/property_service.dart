import 'package:dio/dio.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/storage/storage.dart';
import 'package:uuid/uuid.dart';

class PropertyService{
  final Dio dio;

  PropertyService({required this.dio});

  Future<ApiResponse<Property?>> getPropertyByGuid(UuidValue guid) async {
    try{
      final response = await dio.get(
          '/api/realty/property/get/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Property?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Property.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiPaginationResponse<List<Property>>> getPropertyList(int offset, limit) async {
    try{
      final Map<String, dynamic> parameters = {
        "offset": offset,
        "limit": limit
      };

      final filter = getIt<PropertyFilterStorage>().filter;

      final response = await dio.post(
        '/api/realty/property/list',
        options: Options(contentType: Headers.jsonContentType),
        data: filter,
        queryParameters: parameters
      );

      return ApiPaginationResponse<List<Property>>.fromJson(response.data, (data){
        if (data is List) {
          List<Property> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Property.fromJson(item))
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
  Future<void> createProperty(Property model) async {
    try{
      await dio.post(
          '/api/realty/property/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> updateProperty(Property model) async {
    try{
      await dio.post(
          '/api/realty/property/update',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> deleteProperty(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/property/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
}