
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid_value.dart';

abstract class BookingVenueEvent {
  final bool debounce;
  final int debounceMillisecond;

  final DateTime? startTime;
  final DateTime? expectedEndTime;
  final String? venueName;
  final String? venueShortAddress;
  final String? phone;
  final String? guestName;
  final int? guestCount;
  final String? specialRequest;

  final double? amount;

  final List<BookingMenuItem>? menuItems;
  final List<BookingTable>? tables;

  BookingVenueEvent({
    this.startTime,
    this.expectedEndTime,
    this.venueName,
    this.venueShortAddress,
    this.phone,
    this.guestName,
    this.guestCount,
    this.specialRequest,
    this.amount,
    this.menuItems,
    this.tables,
    this.debounce = false,
    this.debounceMillisecond = 600,
  });

}

class OnBookingVenueInitialEvent extends BookingVenueEvent {
  final UuidValue guid;

  final UuidValue venueGUID;
  final UuidValue userGUID;
  final UuidValue? promoGUID;

  OnBookingVenueInitialEvent({
    super.startTime,
    super.expectedEndTime,
    super.venueName,
    super.venueShortAddress,
    super.phone,
    super.guestName,
    super.guestCount,
    super.specialRequest,
    super.amount,
    super.menuItems,
    super.tables,
    super.debounce,
    super.debounceMillisecond,
    required this.guid,
    required this.venueGUID,
    required this.userGUID,
    this.promoGUID
  });
}
class OnBookingVenueUpdateEvent extends BookingVenueEvent {
  OnBookingVenueUpdateEvent({
    super.startTime,
    super.expectedEndTime,
    super.venueName,
    super.venueShortAddress,
    super.phone,
    super.guestName,
    super.guestCount,
    super.specialRequest,
    super.amount,
    super.menuItems,
    super.tables,
    super.debounce,
    super.debounceMillisecond,
  });
}
class OnBookingVenueSendEvent extends BookingVenueEvent {}