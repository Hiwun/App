// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedContact _$RelatedContactFromJson(Map<String, dynamic> json) =>
    RelatedContact(
      comment: json['comment'] as String,
      relatedContactGUID: const UuidValueConverter().fromJson(
        json['related_contact_guid'] as String,
      ),
      toRelationContactGUID: const UuidValueConverter().fromJson(
        json['to_relation_contact_guid'] as String,
      ),
      guid: const UuidValueConverter().fromJson(json['guid'] as String),
    );

Map<String, dynamic> _$RelatedContactToJson(RelatedContact instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'related_contact_guid': const UuidValueConverter().toJson(
        instance.relatedContactGUID,
      ),
      'to_relation_contact_guid': const UuidValueConverter().toJson(
        instance.toRelationContactGUID,
      ),
      'guid': const UuidValueConverter().toJson(instance.guid),
    };
