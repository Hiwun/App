import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'contact.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Contact {

  final String fullName;
  final String displayName;
  final String type;
  final String passportSeries;
  final String passportNumber;
  final String companyName;
  final String inn;
  final String kpp;
  final String notes;
  final String source;
  final List<String> phoneNumbers;
  final List<String> emails;
  final Map<String, String> messengers;
  final Map<String, dynamic> address;
  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<RelatedContact> relatedContacts;


  Contact({
    required this.userGUID,
    required this.type,
    required this.fullName,
    required this.displayName,
    required this.passportSeries,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.passportNumber,
    required this.companyName,
    required this.inn,
    required this.kpp,
    required this.phoneNumbers,
    required this.emails,
    required this.messengers,
    required this.address,
    required this.notes,
    required this.source,
    required this.relatedContacts,
    this.companyGUID,
    required this.guid,
  });


  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson () => _$ContactToJson(this);
}