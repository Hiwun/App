// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiResponse<T>(
  data: fromJsonT(json['data']),
  status: json['status'] as String,
  description: json['description'] as String,
  error: json['error'] as String?,
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': toJsonT(instance.data),
  'status': instance.status,
  'description': instance.description,
  'error': instance.error,
};

ApiPaginationResponse<T> _$ApiPaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiPaginationResponse<T>(
  data: fromJsonT(json['data']),
  pagination: ApiPagination.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ApiPaginationResponseToJson<T>(
  ApiPaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': toJsonT(instance.data),
  'pagination': instance.pagination,
};

ApiPagination _$ApiPaginationFromJson(Map<String, dynamic> json) =>
    ApiPagination(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$ApiPaginationToJson(ApiPagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'pages': instance.pages,
    };
