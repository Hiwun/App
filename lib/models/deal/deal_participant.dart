import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'deal_participant.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DealParticipant {

  final String role;
  final double commissionShare;
  final bool isCommissionFixed;
  final double commissionFixed;
  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @UuidValueConverter()
  @JsonKey(name: 'deal_guid')
  final UuidValue? dealGUID;


  DealParticipant({
    required this.userGUID,
    required this.dealGUID,
    required this.commissionShare,
    required this.role,
    required this.isCommissionFixed,
    required this.commissionFixed,
    required this.createdAt,
    required this.updatedAt,
  });


  factory DealParticipant.fromJson(Map<String, dynamic> json) => _$DealParticipantFromJson(json);
  Map<String, dynamic> toJson () => _$DealParticipantToJson(this);
}