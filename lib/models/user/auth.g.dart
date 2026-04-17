// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPhoneResponse _$AuthPhoneResponseFromJson(Map<String, dynamic> json) =>
    AuthPhoneResponse(
      userGUID: const UuidValueConverter().fromJson(
        json['user_guid'] as String,
      ),
    );

Map<String, dynamic> _$AuthPhoneResponseToJson(AuthPhoneResponse instance) =>
    <String, dynamic>{
      'user_guid': const UuidValueConverter().toJson(instance.userGUID),
    };

AuthPhoneCheckCodeRequest _$AuthPhoneCheckCodeRequestFromJson(
  Map<String, dynamic> json,
) => AuthPhoneCheckCodeRequest(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  code: (json['code'] as num).toInt(),
);

Map<String, dynamic> _$AuthPhoneCheckCodeRequestToJson(
  AuthPhoneCheckCodeRequest instance,
) => <String, dynamic>{
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'code': instance.code,
};

AuthPhoneRequest _$AuthPhoneRequestFromJson(Map<String, dynamic> json) =>
    AuthPhoneRequest(phone: json['phone'] as String);

Map<String, dynamic> _$AuthPhoneRequestToJson(AuthPhoneRequest instance) =>
    <String, dynamic>{'phone': instance.phone};
