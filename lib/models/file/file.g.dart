// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
  name: json['name'] as String,
  extension: json['extension'] as String,
  isImage: json['is_image'] as bool,
  isPublic: json['is_public'] as bool,
  bucketName: json['bucket_name'] as String,
  objectName: json['object_name'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
  'name': instance.name,
  'extension': instance.extension,
  'bucket_name': instance.bucketName,
  'object_name': instance.objectName,
  'is_image': instance.isImage,
  'is_public': instance.isPublic,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'guid': const UuidValueConverter().toJson(instance.guid),
};
