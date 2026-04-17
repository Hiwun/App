
import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationModel {
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;

  final String title;
  final String type;
  final String description;
  final bool isChecked;

  final DateTime createdAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  NotificationModel({
    required this.userGUID,
    required this.title,
    required this.type,
    required this.description,
    required this.isChecked,
    required this.createdAt,
    required this.guid
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson () => _$NotificationModelToJson(this);

}