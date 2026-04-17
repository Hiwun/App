import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid_value.dart';

part 'booking.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Booking {

  @UuidValueConverter()
  @JsonKey(name: 'venue_guid')
  final UuidValue venueGUID;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'promo_guid')
  final UuidValue? promoGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'performed_by_guid')
  final UuidValue? performedByGUID;
  final String? performedByName;

  @UtcDateTimeConverter()
  final DateTime startTime;
  @UtcDateTimeConverter()
  final DateTime expectedEndTime;
  @NullableUtcDateTimeConverter()
  final DateTime? actualEndTime;
  final String venueName;
  final String venueShortAddress;
  final String status;
  final String phone;
  final String guestName;
  final int guestCount;
  final String specialRequest;

  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  @NullableUuidValueConverter()
  @JsonKey(name: 'payment_guid')
  final UuidValue? paymentGUID;
  final double? amount;
  final String? paymentStatus;
  final DateTime? paidAt;

  final List<BookingMenuItem> menuItems;
  final List<BookingTable> tables;

  Booking({
    required this.venueGUID,
    required this.userGUID,
    this.promoGUID,
    this.performedByGUID,
    this.performedByName,
    required this.startTime,
    required this.expectedEndTime,
    this.actualEndTime,
    required this.status,
    required this.venueName,
    required this.venueShortAddress,
    required this.phone,
    required this.guestName,
    required this.guestCount,
    required this.specialRequest,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.guid,
    this.paymentGUID,
    this.amount,
    this.paymentStatus,
    this.paidAt,
    required this.menuItems,
    required this.tables
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BookingTable {

  @UuidValueConverter()
  @JsonKey(name: 'booking_guid')
  final UuidValue bookingGUID;
  final String title;
  @UuidValueConverter()
  @JsonKey(name: 'table_guid')
  final UuidValue tableGUID;

  BookingTable({required this.bookingGUID, required this.title, required this.tableGUID});

  factory BookingTable.fromJson(Map<String, dynamic> json) => _$BookingTableFromJson(json);

  Map<String, dynamic> toJson() => _$BookingTableToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BookingMenuItem {

  @UuidValueConverter()
  @JsonKey(name: 'booking_guid')
  final UuidValue bookingGUID;
  @UuidValueConverter()
  @JsonKey(name: 'menu_item_guid')
  final UuidValue menuItemGUID;
  final String type;
  final String title;
  final double price;
  final int quantity;

  BookingMenuItem({required this.bookingGUID, required this.menuItemGUID, required this.type, required this.title, required this.price, required this.quantity});

  factory BookingMenuItem.fromJson(Map<String, dynamic> json) => _$BookingMenuItemFromJson(json);


  Map<String, dynamic> toJson() => _$BookingMenuItemToJson(this);
}