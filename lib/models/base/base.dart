

import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true, // Add this
)
class ApiResponse<T> {
  final T data;
  final String status;
  final String description;
  final String? error;

  ApiResponse({
    required this.data,
    required this.status,
    required this.description,
    required this.error,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT, // Add this parameter
      ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
      Object? Function(T value) toJsonT, // Add this parameter
      ) => _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true, // Add this
)
class ApiPaginationResponse<T> {
  final T data;
  final ApiPagination pagination;

  ApiPaginationResponse({
    required this.data,
    required this.pagination,
  });

  factory ApiPaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT, // Add this parameter
      ) => _$ApiPaginationResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
      Object? Function(T value) toJsonT, // Add this parameter
      ) => _$ApiPaginationResponseToJson(this, toJsonT);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiPagination{
  final int page;
  final int limit;
  final int offset;
  final int total;
  final int pages;

  ApiPagination({required this.page, required this.limit, required this.offset, required this.total, required this.pages});

  factory ApiPagination.fromJson(Map<String, dynamic> json) => _$ApiPaginationFromJson(json);
  Map<String, dynamic> toJson () => _$ApiPaginationToJson(this);
}