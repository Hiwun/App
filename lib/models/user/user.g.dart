// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  DateTime.parse(json['created_at'] as String),
  DateTime.parse(json['updated_at'] as String),
  json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  const UuidValueConverter().fromJson(json['guid'] as String),
  json['phone'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'phone': instance.phone,
};
