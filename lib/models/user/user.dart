
import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User{
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;
  final String phone;

  User(this.createdAt, this.updatedAt, this.deletedAt, this.guid, this.phone);


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson () => _$UserToJson(this);
}



