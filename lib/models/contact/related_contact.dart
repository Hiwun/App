import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'related_contact.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RelatedContact {

  final String comment;
  @UuidValueConverter()
  @JsonKey(name: 'related_contact_guid')
  final UuidValue relatedContactGUID;
  @UuidValueConverter()
  @JsonKey(name: 'to_relation_contact_guid')
  final UuidValue toRelationContactGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;



  RelatedContact({
    required this.comment,
    required this.relatedContactGUID,
    required this.toRelationContactGUID,
    required this.guid
  });


  factory RelatedContact.fromJson(Map<String, dynamic> json) => _$RelatedContactFromJson(json);
  Map<String, dynamic> toJson () => _$RelatedContactToJson(this);
}