
import 'package:uuid/uuid.dart';

abstract class BookingListEvent {}

class OnBookingListInitialEvent extends BookingListEvent {}
class OnBookingListLoadMoreEvent extends BookingListEvent {}
class OnBookingListRefreshListEvent extends BookingListEvent {}
class OnBookingListRequestCancelEvent extends BookingListEvent {
  final UuidValue guid;

  OnBookingListRequestCancelEvent({required this.guid});

}