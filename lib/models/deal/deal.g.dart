// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) => Deal(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  type: json['type'] as String,
  title: json['title'] as String,
  stage: json['stage'] as String,
  notes: json['notes'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  dealAmount: (json['deal_amount'] as num).toDouble(),
  dealCurrency: json['deal_currency'] as String,
  commissionTotal: (json['commission_total'] as num).toDouble(),
  commissionCurrency: json['commission_currency'] as String,
  propertyGUID: const UuidValueConverter().fromJson(
    json['property_guid'] as String,
  ),
  sellerContactGUID: const UuidValueConverter().fromJson(
    json['seller_contact_guid'] as String,
  ),
  buyerContactGUID: const UuidValueConverter().fromJson(
    json['buyer_contact_guid'] as String,
  ),
  plannedCloseDate: const NullableUtcDateTimeConverter().fromJson(
    json['planned_close_date'] as String?,
  ),
  actualCloseDate: const NullableUtcDateTimeConverter().fromJson(
    json['actual_close_date'] as String?,
  ),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  participants: (json['participants'] as List<dynamic>)
      .map((e) => DealParticipant.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
  'title': instance.title,
  'stage': instance.stage,
  'type': instance.type,
  'deal_amount': instance.dealAmount,
  'deal_currency': instance.dealCurrency,
  'commission_total': instance.commissionTotal,
  'commission_currency': instance.commissionCurrency,
  'planned_close_date': const NullableUtcDateTimeConverter().toJson(
    instance.plannedCloseDate,
  ),
  'actual_close_date': const NullableUtcDateTimeConverter().toJson(
    instance.actualCloseDate,
  ),
  'notes': instance.notes,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'property_guid': const UuidValueConverter().toJson(instance.propertyGUID),
  'seller_contact_guid': const UuidValueConverter().toJson(
    instance.sellerContactGUID,
  ),
  'buyer_contact_guid': const UuidValueConverter().toJson(
    instance.buyerContactGUID,
  ),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'participants': instance.participants,
};
