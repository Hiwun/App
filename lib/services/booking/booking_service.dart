import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class BookingService{
  final Dio dio;

  BookingService({required this.dio});

  Future<void> book(Booking model) async {
    try{
      await dio.post(
          '/api/restorator/booking/book',
          data: model,
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<void> requestCancelBooking(UuidValue guid) async {
    try{
      await dio.get(
          '/api/restorator/booking/cancel/$guid',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<ApiResponse<NextEvent?>> getNextEventUser() async {
    try{
      final response = await dio.get(
          '/api/restorator/booking/next/event',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );

      return ApiResponse<NextEvent?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return NextEvent.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });

    } catch(e){
      rethrow;
    }
  }
  Future<ApiPaginationResponse<List<Booking>>> getUserBookings(int offset, limit) async {
    try{
      final response = await dio.post(
          '/api/restorator/booking/list?offset=$offset&limit=$limit',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiPaginationResponse<List<Booking>>.fromJson(response.data, (data){
        if (data is List) {
          List<Booking> items = data
              .whereType<Map<String, dynamic>>()
              .map((item) => Booking.fromJson(item))
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