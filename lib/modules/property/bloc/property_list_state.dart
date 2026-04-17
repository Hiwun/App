import 'package:tennisapp/models/model.dart';

enum PropertyListStatus { initial, success, failure, loading}

class PropertyListState {
  final PropertyListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final List<Property> items;
  final String? errorMessage;

  PropertyListState({
    this.status = PropertyListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.items = const [],
    this.errorMessage
  });

  PropertyListState copyWith({
    PropertyListStatus? status,
    List<Property>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return PropertyListState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        items: items ?? this.items,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset
    );
  }
}