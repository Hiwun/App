import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class CompanyService{
  final Dio dio;

  CompanyService({required this.dio});

  Future<ApiResponse<Company?>> getCompanyByUserGuid() async {
    try{
      final response = await dio.get(
          '/api/realty/company/get/',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<Company?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return Company.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiResponse<bool>> hasCompanyByUserGuid() async {
    try{
      final response = await dio.get(
          '/api/realty/company/has/',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<bool>.fromJson(response.data, (data){
        if (data is bool) {
          return data;
        } else {
          return false; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<ApiResponse<List<UserCompany>>> getUsersCompany() async {
    try{
      final response = await dio.get(
          '/api/realty/company/users/',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<List<UserCompany>>.fromJson(response.data, (data){
        if (data is List<UserCompany>) {
          List<UserCompany> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => UserCompany.fromJson(item))
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
  Future<void> inviteUserToCompany(UuidValue companyGuid, UuidValue userGuid) async {
    try{
      final Map<String, dynamic> parameters = {
        "company_guid": companyGuid.uuid,
        "user_guid": userGuid.uuid
      };
      await dio.post(
        '/api/realty/company/invite',
        options: Options(
            contentType: Headers.jsonContentType
        ),
        queryParameters: parameters
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> removeUserToCompany(UuidValue companyGuid, UuidValue userGuid) async {
    try{
      final Map<String, dynamic> parameters = {
        "company_guid": companyGuid.uuid,
        "user_guid": userGuid.uuid
      };
      await dio.post(
        '/api/realty/company/remove',
        options: Options(
            contentType: Headers.jsonContentType
        ),
        queryParameters: parameters
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> createCompany(Company model) async {
    try{
      await dio.post(
          '/api/realty/company/create',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> updateCompany(Company model) async {
    try{
      await dio.post(
          '/api/realty/company/update',
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