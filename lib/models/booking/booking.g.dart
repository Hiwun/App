// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  venueGUID: const UuidValueConverter().fromJson(json['venue_guid'] as String),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  promoGUID: const NullableUuidValueConverter().fromJson(
    json['promo_guid'] as String?,
  ),
  performedByGUID: const NullableUuidValueConverter().fromJson(
    json['performed_by_guid'] as String?,
  ),
  performedByName: json['performed_by_name'] as String?,
  startTime: const UtcDateTimeConverter().fromJson(
    json['start_time'] as String,
  ),
  expectedEndTime: const UtcDateTimeConverter().fromJson(
    json['expected_end_time'] as String,
  ),
  actualEndTime: const NullableUtcDateTimeConverter().fromJson(
    json['actual_end_time'] as String?,
  ),
  status: json['status'] as String,
  venueName: json['venue_name'] as String,
  venueShortAddress: json['venue_short_address'] as String,
  phone: json['phone'] as String,
  guestName: json['guest_name'] as String,
  guestCount: (json['guest_count'] as num).toInt(),
  specialRequest: json['special_request'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  paymentGUID: const NullableUuidValueConverter().fromJson(
    json['payment_guid'] as String?,
  ),
  amount: (json['amount'] as num?)?.toDouble(),
  paymentStatus: json['payment_status'] as String?,
  paidAt: json['paid_at'] == null
      ? null
      : DateTime.parse(json['paid_at'] as String),
  menuItems: (json['menu_items'] as List<dynamic>)
      .map((e) => BookingMenuItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  tables: (json['tables'] as List<dynamic>)
      .map((e) => BookingTable.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'venue_guid': const UuidValueConverter().toJson(instance.venueGUID),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'promo_guid': const NullableUuidValueConverter().toJson(instance.promoGUID),
  'performed_by_guid': const NullableUuidValueConverter().toJson(
    instance.performedByGUID,
  ),
  'performed_by_name': instance.performedByName,
  'start_time': const UtcDateTimeConverter().toJson(instance.startTime),
  'expected_end_time': const UtcDateTimeConverter().toJson(
    instance.expectedEndTime,
  ),
  'actual_end_time': const NullableUtcDateTimeConverter().toJson(
    instance.actualEndTime,
  ),
  'venue_name': instance.venueName,
  'venue_short_address': instance.venueShortAddress,
  'status': instance.status,
  'phone': instance.phone,
  'guest_name': instance.guestName,
  'guest_count': instance.guestCount,
  'special_request': instance.specialRequest,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'payment_guid': const NullableUuidValueConverter().toJson(
    instance.paymentGUID,
  ),
  'amount': instance.amount,
  'payment_status': instance.paymentStatus,
  'paid_at': instance.paidAt?.toIso8601String(),
  'menu_items': instance.menuItems,
  'tables': instance.tables,
};

BookingTable _$BookingTableFromJson(Map<String, dynamic> json) => BookingTable(
  bookingGUID: const UuidValueConverter().fromJson(
    json['booking_guid'] as String,
  ),
  title: json['title'] as String,
  tableGUID: const UuidValueConverter().fromJson(json['table_guid'] as String),
);

Map<String, dynamic> _$BookingTableToJson(BookingTable instance) =>
    <String, dynamic>{
      'booking_guid': const UuidValueConverter().toJson(instance.bookingGUID),
      'title': instance.title,
      'table_guid': const UuidValueConverter().toJson(instance.tableGUID),
    };

BookingMenuItem _$BookingMenuItemFromJson(Map<String, dynamic> json) =>
    BookingMenuItem(
      bookingGUID: const UuidValueConverter().fromJson(
        json['booking_guid'] as String,
      ),
      menuItemGUID: const UuidValueConverter().fromJson(
        json['menu_item_guid'] as String,
      ),
      type: json['type'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BookingMenuItemToJson(
  BookingMenuItem instance,
) => <String, dynamic>{
  'booking_guid': const UuidValueConverter().toJson(instance.bookingGUID),
  'menu_item_guid': const UuidValueConverter().toJson(instance.menuItemGUID),
  'type': instance.type,
  'title': instance.title,
  'price': instance.price,
  'quantity': instance.quantity,
};
