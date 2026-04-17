// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      userGUID: const UuidValueConverter().fromJson(
        json['user_guid'] as String,
      ),
      title: json['title'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      isChecked: json['is_checked'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      guid: const UuidValueConverter().fromJson(json['guid'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'user_guid': const UuidValueConverter().toJson(instance.userGUID),
      'title': instance.title,
      'type': instance.type,
      'description': instance.description,
      'is_checked': instance.isChecked,
      'created_at': instance.createdAt.toIso8601String(),
      'guid': const UuidValueConverter().toJson(instance.guid),
    };
