import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'deal.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Deal {

  final String title;
  final String stage;
  final String type;
  final double dealAmount;
  final String dealCurrency;
  final double commissionTotal;
  final String commissionCurrency;
  @NullableUtcDateTimeConverter()
  final DateTime? plannedCloseDate;
  @NullableUtcDateTimeConverter()
  final DateTime? actualCloseDate;
  final String notes;
  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'property_guid')
  final UuidValue propertyGUID;
  @UuidValueConverter()
  @JsonKey(name: 'seller_contact_guid')
  final UuidValue sellerContactGUID;
  @UuidValueConverter()
  @JsonKey(name: 'buyer_contact_guid')
  final UuidValue buyerContactGUID;

  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<DealParticipant> participants;


  Deal({
    required this.userGUID,
    required this.type,
    required this.title,
    required this.stage,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dealAmount,
    required this.dealCurrency,
    required this.commissionTotal,
    required this.commissionCurrency,
    required this.propertyGUID,
    required this.sellerContactGUID,
    required this.buyerContactGUID,
    this.plannedCloseDate,
    this.actualCloseDate,
    this.companyGUID,
    required this.guid,
    required this.participants,
  });


  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
  Map<String, dynamic> toJson () => _$DealToJson(this);
}