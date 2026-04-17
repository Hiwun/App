import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'next_event.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NextEvent {

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;
  @UuidValueConverter()
  @JsonKey(name: 'venue_guid')
  final UuidValue venueGUID;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;

  @NullableUuidValueConverter()
  @JsonKey(name: 'performed_by_guid')
  final UuidValue? performedByGUID;
  final DateTime startTime;
  final String venueName;
  final String venueShortAddress;
  final String guestName;
  final int guestCount;
  final String status;
  final String? performedByName;

  @NullableUuidValueConverter()
  @JsonKey(name: 'payment_guid')
  final UuidValue? paymentGUID;
  final double? amount;
  final String? paymentStatus;
  final DateTime? paidAt;

  NextEvent({
    required this.guid,
    required this.venueGUID,
    required this.userGUID,
    this.performedByGUID,
    required this.startTime,
    required this.venueName,
    required this.venueShortAddress,
    required this.guestName,
    required this.guestCount,
    required this.status,
    this.performedByName,
    this.paymentGUID,
    this.amount,
    this.paymentStatus,
    this.paidAt
  });

  factory NextEvent.fromJson(Map<String, dynamic> json) => _$NextEventFromJson(json);

  Map<String, dynamic> toJson () => _$NextEventToJson(this);


}