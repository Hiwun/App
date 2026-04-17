import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FileModel {

  final String name;
  final String extension;
  final String bucketName;
  final String objectName;
  final bool isImage;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  FileModel({
    required this.name,
    required this.extension,
    required this.isImage,
    required this.isPublic,
    required this.bucketName,
    required this.objectName,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userGUID,
    required this.guid,
  });


  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);
  Map<String, dynamic> toJson () => _$FileModelToJson(this);
}