
import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';

class PromotionService {
  final Dio dio;

  PromotionService({required this.dio});



  Future<ApiPaginationResponse<List<Promotion>>> getPromotionList(int offset, limit) async {
    try{
      final response = await dio.post(
          '/api/restorator/promo/list?offset=$offset&limit=$limit',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Promotion>>.fromJson(response.data, (data){
        if (data is List) {
          List<Promotion> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Promotion.fromJson(item))
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

  Future<ApiPaginationResponse<List<Promotion>>> getPromotionTop() async {
    try{
      final response = await dio.get(
          '/api/restorator/promo/top',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Promotion>>.fromJson(response.data, (data){
        if (data is List) {
          List<Promotion> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Promotion.fromJson(item))
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
  Future<ApiPaginationResponse<List<Promotion>>> getPromotionTopCenter() async {
    try{
      final response = await dio.get(
          '/api/restorator/promo/top/center',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Promotion>>.fromJson(response.data, (data){
        if (data is List) {
          List<Promotion> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Promotion.fromJson(item))
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