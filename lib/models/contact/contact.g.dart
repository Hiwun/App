// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  type: json['type'] as String,
  fullName: json['full_name'] as String,
  displayName: json['display_name'] as String,
  passportSeries: json['passport_series'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  passportNumber: json['passport_number'] as String,
  companyName: json['company_name'] as String,
  inn: json['inn'] as String,
  kpp: json['kpp'] as String,
  phoneNumbers: (json['phone_numbers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  emails: (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
  messengers: Map<String, String>.from(json['messengers'] as Map),
  address: json['address'] as Map<String, dynamic>,
  notes: json['notes'] as String,
  source: json['source'] as String,
  relatedContacts: (json['related_contacts'] as List<dynamic>)
      .map((e) => RelatedContact.fromJson(e as Map<String, dynamic>))
      .toList(),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'full_name': instance.fullName,
  'display_name': instance.displayName,
  'type': instance.type,
  'passport_series': instance.passportSeries,
  'passport_number': instance.passportNumber,
  'company_name': instance.companyName,
  'inn': instance.inn,
  'kpp': instance.kpp,
  'notes': instance.notes,
  'source': instance.source,
  'phone_numbers': instance.phoneNumbers,
  'emails': instance.emails,
  'messengers': instance.messengers,
  'address': instance.address,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'related_contacts': instance.relatedContacts,
};
