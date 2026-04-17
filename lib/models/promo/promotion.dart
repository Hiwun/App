import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'promotion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Promotion {
  @UuidValueConverter()
  @JsonKey(name: 'venue_guid')
  final UuidValue venueGUID;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;

  final String title;
  final String firstTitle;
  final String twoTitle;
  final String threeTitle;
  final String type;
  final String description;
  final String imageUrl;
  final String status;
  final int seq;
  final DateTime startTime;
  final DateTime endTime;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  Promotion({
    required this.venueGUID,
    required this.userGUID,
    required this.title,
    required this.firstTitle,
    required this.twoTitle,
    required this.threeTitle,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.seq,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.guid
  });

  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);
  Map<String, dynamic> toJson () => _$PromotionToJson(this);
}