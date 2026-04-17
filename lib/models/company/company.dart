import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'company.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Company {

  final String mode;
  final String tokenOrganisation;
  final String name;
  final String printName;
  final String? bxCompanyDomain;
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
  @JsonKey(name: 'guid')
  final UuidValue guid;



  Company({
    required this.userGUID,
    required this.mode,
    required this.tokenOrganisation,
    required this.name,
    required this.printName,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.bxCompanyDomain,
    required this.guid,
  });


  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson () => _$CompanyToJson(this);
}