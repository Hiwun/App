// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
  type: json['type'] as String,
  text: json['text'] as String,
  files: (json['files'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  filesGUIDs: (json['files_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  entityGUID: const UuidValueConverter().fromJson(
    json['entity_guid'] as String,
  ),
  entityType: json['entity_type'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
  'type': instance.type,
  'text': instance.text,
  'entity_type': instance.entityType,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'entity_guid': const UuidValueConverter().toJson(instance.entityGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'files_guids': instance.filesGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'files': instance.files,
};
