// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCompany _$UserCompanyFromJson(Map<String, dynamic> json) => UserCompany(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  companyGUID: _$JsonConverterFromJson<String, UuidValue>(
    json['company_guid'],
    const UuidValueConverter().fromJson,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$UserCompanyToJson(
  UserCompany instance,
) => <String, dynamic>{
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': _$JsonConverterToJson<String, UuidValue>(
    instance.companyGUID,
    const UuidValueConverter().toJson,
  ),
  'guid': const UuidValueConverter().toJson(instance.guid),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
