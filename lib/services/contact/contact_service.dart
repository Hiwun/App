import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class ContactService{
  final Dio dio;

  ContactService({required this.dio});

  Future<ApiResponse<Contact?>> getContactByGuid(UuidValue guid) async {
    try{
      final response = await dio.get(
          '/api/realty/contact/get/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Contact?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Contact.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiPaginationResponse<List<Contact>>> getContactList(int offset, limit) async {
    try{
      final Map<String, dynamic> parameters = {
        "offset": offset,
        "limit": limit
      };

      final response = await dio.post(
          '/api/realty/contact/list',
          options: Options(contentType: Headers.jsonContentType),
          queryParameters: parameters
      );

      return ApiPaginationResponse<List<Contact>>.fromJson(response.data, (data){
        if (data is List) {
          List<Contact> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Contact.fromJson(item))
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
  Future<void> createContact(Contact model) async {
    try{
      await dio.post(
          '/api/realty/contact/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> updateContact(Contact model) async {
    try{
      await dio.post(
          '/api/realty/contact/update',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> deleteContact(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/contact/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
}