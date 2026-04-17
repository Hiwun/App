import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class VenueService{
  final Dio dio;

  VenueService({required this.dio});

  Future<ApiResponse<Venue?>> getVenueByGuid(UuidValue guid) async {
    try{
      final response = await dio.post(
          '/api/restorator/venue/get/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Venue?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Venue.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiResponse<List<TableAvailability>>> getPublicAvailabilityTables({required UuidValue guid, DateTime? requestTime}) async {
    try{
      final Map<String, dynamic> parameters = {
        "request_time": requestTime?.toUtc().toIso8601String()
      };

      final response = await dio.get(
        '/api/restorator/venue/tables/availability/${guid.uuid}',
        options: Options(contentType: Headers.jsonContentType),
        queryParameters: parameters
      );

      return ApiResponse<List<TableAvailability>>.fromJson(response.data, (data){
        if (data is List) {
          List<TableAvailability> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => TableAvailability.fromJson(item))
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
  Future<ApiResponse<List<VenueZone>>> getPublicVenueHallMaps(UuidValue guid) async {
    try{
      final response = await dio.get(
        '/api/restorator/venue/hall/${guid.uuid}',
        options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<List<VenueZone>>.fromJson(response.data, (data){
        if (data is List) {
          List<VenueZone> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => VenueZone.fromJson(item))
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
  Future<ApiResponse<List<MenuCategory>>> getPublicVenueMenu({required UuidValue guid, DateTime? requestTime}) async {
    try{

      final Map<String, dynamic> parameters = {
        "request_time": requestTime?.toUtc().toIso8601String()
      };

      final response = await dio.get(
        '/api/restorator/venue/menu/${guid.uuid}',
        options: Options(contentType: Headers.jsonContentType),
        queryParameters: parameters
      );

      return ApiResponse<List<MenuCategory>>.fromJson(response.data, (data){
        if (data is List) {
          List<MenuCategory> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => MenuCategory.fromJson(item))
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
  Future<ApiPaginationResponse<List<Venue>>> getVenueList(int offset, limit) async {
    try{
      final response = await dio.post(
          '/api/restorator/venue/list?offset=$offset&limit=$limit',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Venue>>.fromJson(response.data, (data){
        if (data is List) {
          List<Venue> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Venue.fromJson(item))
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
  Future<ApiPaginationResponse<List<Venue>>> getVenueMapList(int offset, limit) async {
    try{
      final response = await dio.post(
          '/api/restorator/venue/list/map?offset=$offset&limit=$limit',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Venue>>.fromJson(response.data, (data){
        if (data is List) {
          List<Venue> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Venue.fromJson(item))
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