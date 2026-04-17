// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealParticipant _$DealParticipantFromJson(Map<String, dynamic> json) =>
    DealParticipant(
      userGUID: const UuidValueConverter().fromJson(
        json['user_guid'] as String,
      ),
      dealGUID: _$JsonConverterFromJson<String, UuidValue>(
        json['deal_guid'],
        const UuidValueConverter().fromJson,
      ),
      commissionShare: (json['commission_share'] as num).toDouble(),
      role: json['role'] as String,
      isCommissionFixed: json['is_commission_fixed'] as bool,
      commissionFixed: (json['commission_fixed'] as num).toDouble(),
      createdAt: const UtcDateTimeConverter().fromJson(
        json['created_at'] as String,
      ),
      updatedAt: const UtcDateTimeConverter().fromJson(
        json['updated_at'] as String,
      ),
    );

Map<String, dynamic> _$DealParticipantToJson(DealParticipant instance) =>
    <String, dynamic>{
      'role': instance.role,
      'commission_share': instance.commissionShare,
      'is_commission_fixed': instance.isCommissionFixed,
      'commission_fixed': instance.commissionFixed,
      'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
      'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
      'user_guid': const UuidValueConverter().toJson(instance.userGUID),
      'deal_guid': _$JsonConverterToJson<String, UuidValue>(
        instance.dealGUID,
        const UuidValueConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
