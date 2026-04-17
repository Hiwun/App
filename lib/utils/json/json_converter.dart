import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_value.dart';

class UuidValueConverter implements JsonConverter<UuidValue, String> {
  const UuidValueConverter();

  @override
  UuidValue fromJson(String json) => UuidValue.fromString(json);

  @override
  String toJson(UuidValue object) => object.uuid;
}

class UtcDateTimeConverter implements JsonConverter<DateTime, String> {
  const UtcDateTimeConverter();
  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();
  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

class NullableUtcDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const NullableUtcDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) return null;
    return DateTime.parse(json).toLocal();
  }

  @override
  String? toJson(DateTime? object) => object?.toUtc().toIso8601String();
}

class NullableUuidValueConverter implements JsonConverter<UuidValue?, String?> {
  const NullableUuidValueConverter();

  @override
  UuidValue? fromJson(String? json) {
    if (json == null) return null;
    return UuidValue.fromString(json);
  }

  @override
  String? toJson(UuidValue? object) => object?.uuid;
}
