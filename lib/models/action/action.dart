import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'action.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Action {

  final String actionType;
  final String title;
  final String entityType;
  final String description;
  final String status;
  final String category;
  final String result;
  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? scheduledAt;
  @NullableUtcDateTimeConverter()
  final DateTime? completedAt;
  @UuidValueConverter()
  @JsonKey(name: 'entity_guid')
  final UuidValue entityGUID;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @NullableUuidValueConverter()
  @JsonKey(name: 'property_guid')
  final UuidValue? propertyGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'contact_guid')
  final UuidValue? contactGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'need_guid')
  final UuidValue? needGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<ActionUser> users;


  Action({
    required this.actionType,
    required this.entityType,
    required this.status,
    required this.category,
    required this.result,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contactGUID,
    this.needGUID,
    this.propertyGUID,
    required this.entityGUID,
    required this.userGUID,
    required this.users,
    this.scheduledAt,
    this.completedAt,
    this.companyGUID,
    required this.guid,
  });


  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);
  Map<String, dynamic> toJson () => _$ActionToJson(this);
}