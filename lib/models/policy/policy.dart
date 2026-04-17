import 'package:json_annotation/json_annotation.dart';

part 'policy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DepositPolicy{

  DepositPolicy();

  factory DepositPolicy.fromJson(Map<String, dynamic> json) => _$DepositPolicyFromJson(json);

  Map<String, dynamic> toJson () => _$DepositPolicyToJson(this);
}