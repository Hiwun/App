import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_value.dart';

enum BookingVenueStatus { initial, waitFill, success, failure, loading}

class BookingVenueState {
  final BookingVenueStatus status;
  final bool isLoading;
  final String? errorMessage;

  final UuidValue venueGUID;
  final UuidValue userGUID;
  final UuidValue? promoGUID;

  final DateTime startTime;
  final DateTime expectedEndTime;
  final String venueName;
  final String venueShortAddress;
  final String phone;
  final String guestName;
  final int guestCount;
  final String specialRequest;

  final UuidValue guid;

  final double? amount;

  final List<BookingMenuItem>  menuItems;
  final List<BookingTable> tables;

  BookingVenueState({
    this.status = BookingVenueStatus.initial,
    this.isLoading = false,
    this.errorMessage,
    this.venueGUID = UuidValue.nil,
    this.userGUID = UuidValue.nil,
    this.promoGUID,
    required this.startTime,
    required this.expectedEndTime,
    this.venueName = "",
    this.venueShortAddress = "",
    this.phone = "",
    this.guestName = "",
    this.guestCount = 2,
    this.specialRequest = "",
    this.guid = UuidValue.nil,
    this.amount,
    this.menuItems = const [],
    this.tables = const [],
  });

  BookingVenueState copyWith({
    BookingVenueStatus? status,
    String? errorMessage,
    bool? isLoading,
    UuidValue? guid,
    UuidValue? venueGUID,
    UuidValue? userGUID,
    UuidValue? promoGUID,
    DateTime? startTime,
    DateTime? expectedEndTime,
    String? venueName,
    String? venueShortAddress,
    String? phone,
    String? guestName,
    int? guestCount,
    String? specialRequest,
    double? amount,
    List<BookingTable>? tables,
    List<BookingMenuItem>? menuItems,
  }) {
    return BookingVenueState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      guid: guid ?? this.guid,
      venueGUID: venueGUID ?? this.venueGUID,
      userGUID: userGUID ?? this.userGUID,
      promoGUID: promoGUID ?? this.promoGUID,
      startTime: startTime ?? this.startTime,
      expectedEndTime: expectedEndTime ?? this.expectedEndTime,
      venueName: venueName ?? this.venueName,
      venueShortAddress: venueShortAddress ?? this.venueShortAddress,
      phone: phone ?? this.phone,
      guestName: guestName ?? this.guestName,
      guestCount: guestCount ?? this.guestCount,
      specialRequest: specialRequest ?? this.specialRequest,
      amount: amount ?? this.amount,
      menuItems: menuItems ?? this.menuItems,
      tables: tables ?? this.tables,
    );
  }
}