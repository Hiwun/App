// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionUser _$ActionUserFromJson(Map<String, dynamic> json) => ActionUser(
  actionGUID: const UuidValueConverter().fromJson(
    json['action_guid'] as String,
  ),
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
);

Map<String, dynamic> _$ActionUserToJson(ActionUser instance) =>
    <String, dynamic>{
      'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
      'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
      'user_guid': const UuidValueConverter().toJson(instance.userGUID),
      'action_guid': const UuidValueConverter().toJson(instance.actionGUID),
    };
