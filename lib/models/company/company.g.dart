// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  mode: json['mode'] as String,
  tokenOrganisation: json['token_organisation'] as String,
  name: json['name'] as String,
  printName: json['print_name'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  bxCompanyDomain: json['bx_company_domain'] as String?,
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
  'mode': instance.mode,
  'token_organisation': instance.tokenOrganisation,
  'name': instance.name,
  'print_name': instance.printName,
  'bx_company_domain': instance.bxCompanyDomain,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'guid': const UuidValueConverter().toJson(instance.guid),
};
