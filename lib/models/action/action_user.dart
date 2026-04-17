import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'action_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActionUser {

  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @UuidValueConverter()
  @JsonKey(name: 'action_guid')
  final UuidValue actionGUID;

  ActionUser({
    required this.actionGUID,
    required this.createdAt,
    required this.updatedAt,
    required this.userGUID,
  });


  factory ActionUser.fromJson(Map<String, dynamic> json) => _$ActionUserFromJson(json);
  Map<String, dynamic> toJson () => _$ActionUserToJson(this);
}