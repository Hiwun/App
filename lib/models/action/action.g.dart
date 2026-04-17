// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
  actionType: json['action_type'] as String,
  entityType: json['entity_type'] as String,
  status: json['status'] as String,
  category: json['category'] as String,
  result: json['result'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
  contactGUID: const NullableUuidValueConverter().fromJson(
    json['contact_guid'] as String?,
  ),
  needGUID: const NullableUuidValueConverter().fromJson(
    json['need_guid'] as String?,
  ),
  propertyGUID: const NullableUuidValueConverter().fromJson(
    json['property_guid'] as String?,
  ),
  entityGUID: const UuidValueConverter().fromJson(
    json['entity_guid'] as String,
  ),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  users: (json['users'] as List<dynamic>)
      .map((e) => ActionUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  scheduledAt: const NullableUtcDateTimeConverter().fromJson(
    json['scheduled_at'] as String?,
  ),
  completedAt: const NullableUtcDateTimeConverter().fromJson(
    json['completed_at'] as String?,
  ),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
  'action_type': instance.actionType,
  'title': instance.title,
  'entity_type': instance.entityType,
  'description': instance.description,
  'status': instance.status,
  'category': instance.category,
  'result': instance.result,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'scheduled_at': const NullableUtcDateTimeConverter().toJson(
    instance.scheduledAt,
  ),
  'completed_at': const NullableUtcDateTimeConverter().toJson(
    instance.completedAt,
  ),
  'entity_guid': const UuidValueConverter().toJson(instance.entityGUID),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'property_guid': const NullableUuidValueConverter().toJson(
    instance.propertyGUID,
  ),
  'contact_guid': const NullableUuidValueConverter().toJson(
    instance.contactGUID,
  ),
  'need_guid': const NullableUuidValueConverter().toJson(instance.needGUID),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'users': instance.users,
};
