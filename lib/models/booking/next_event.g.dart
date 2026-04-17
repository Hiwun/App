// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextEvent _$NextEventFromJson(Map<String, dynamic> json) => NextEvent(
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  venueGUID: const UuidValueConverter().fromJson(json['venue_guid'] as String),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  performedByGUID: const NullableUuidValueConverter().fromJson(
    json['performed_by_guid'] as String?,
  ),
  startTime: DateTime.parse(json['start_time'] as String),
  venueName: json['venue_name'] as String,
  venueShortAddress: json['venue_short_address'] as String,
  guestName: json['guest_name'] as String,
  guestCount: (json['guest_count'] as num).toInt(),
  status: json['status'] as String,
  performedByName: json['performed_by_name'] as String?,
  paymentGUID: const NullableUuidValueConverter().fromJson(
    json['payment_guid'] as String?,
  ),
  amount: (json['amount'] as num?)?.toDouble(),
  paymentStatus: json['payment_status'] as String?,
  paidAt: json['paid_at'] == null
      ? null
      : DateTime.parse(json['paid_at'] as String),
);

Map<String, dynamic> _$NextEventToJson(NextEvent instance) => <String, dynamic>{
  'guid': const UuidValueConverter().toJson(instance.guid),
  'venue_guid': const UuidValueConverter().toJson(instance.venueGUID),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'performed_by_guid': const NullableUuidValueConverter().toJson(
    instance.performedByGUID,
  ),
  'start_time': instance.startTime.toIso8601String(),
  'venue_name': instance.venueName,
  'venue_short_address': instance.venueShortAddress,
  'guest_name': instance.guestName,
  'guest_count': instance.guestCount,
  'status': instance.status,
  'performed_by_name': instance.performedByName,
  'payment_guid': const NullableUuidValueConverter().toJson(
    instance.paymentGUID,
  ),
  'amount': instance.amount,
  'payment_status': instance.paymentStatus,
  'paid_at': instance.paidAt?.toIso8601String(),
};
