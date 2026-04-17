import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'activity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Activity {

  final String type;
  final String text;
  final String entityType;
  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @UuidValueConverter()
  @JsonKey(name: 'entity_guid')
  final UuidValue entityGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;
  @UuidValueConverter()
  @JsonKey(name: 'files_guids')
  final List<UuidValue> filesGUIDs;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<FileModel> files;

  Activity({
    required this.type,
    required this.text,
    required this.files,
    required this.filesGUIDs,
    required this.entityGUID,
    required this.entityType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userGUID,
    this.companyGUID,
    required this.guid,
  });


  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson () => _$ActivityToJson(this);
}