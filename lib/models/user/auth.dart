import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'auth.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthPhoneResponse {

  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;

  AuthPhoneResponse({
    required this.userGUID,
  });

  factory AuthPhoneResponse.fromJson(Map<String, dynamic> json) => _$AuthPhoneResponseFromJson(json);
  Map<String, dynamic> toJson () => _$AuthPhoneResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthPhoneCheckCodeRequest {

  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  final int code;

  AuthPhoneCheckCodeRequest({
    required this.userGUID,
    required this.code
  });

  factory AuthPhoneCheckCodeRequest.fromJson(Map<String, dynamic> json) => _$AuthPhoneCheckCodeRequestFromJson(json);
  Map<String, dynamic> toJson () => _$AuthPhoneCheckCodeRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthPhoneRequest {
  final String phone;

  AuthPhoneRequest({
    required this.phone,
  });

  factory AuthPhoneRequest.fromJson(Map<String, dynamic> json) => _$AuthPhoneRequestFromJson(json);
  Map<String, dynamic> toJson () => _$AuthPhoneRequestToJson(this);
}