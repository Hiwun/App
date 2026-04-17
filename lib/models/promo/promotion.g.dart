// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
  venueGUID: const UuidValueConverter().fromJson(json['venue_guid'] as String),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  title: json['title'] as String,
  firstTitle: json['first_title'] as String,
  twoTitle: json['two_title'] as String,
  threeTitle: json['three_title'] as String,
  type: json['type'] as String,
  description: json['description'] as String,
  imageUrl: json['image_url'] as String,
  status: json['status'] as String,
  seq: (json['seq'] as num).toInt(),
  startTime: DateTime.parse(json['start_time'] as String),
  endTime: DateTime.parse(json['end_time'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
  'venue_guid': const UuidValueConverter().toJson(instance.venueGUID),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'title': instance.title,
  'first_title': instance.firstTitle,
  'two_title': instance.twoTitle,
  'three_title': instance.threeTitle,
  'type': instance.type,
  'description': instance.description,
  'image_url': instance.imageUrl,
  'status': instance.status,
  'seq': instance.seq,
  'start_time': instance.startTime.toIso8601String(),
  'end_time': instance.endTime.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'guid': const UuidValueConverter().toJson(instance.guid),
};
