import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'user_company.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserCompany {

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
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;


  UserCompany({
    required this.userGUID,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.companyGUID,
    required this.guid,
  });


  factory UserCompany.fromJson(Map<String, dynamic> json) => _$UserCompanyFromJson(json);
  Map<String, dynamic> toJson () => _$UserCompanyToJson(this);
}