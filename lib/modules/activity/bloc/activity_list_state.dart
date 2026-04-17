import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

enum ActivityListStatus { initial, success, failure, loading}

class ActivityListState {
  final ActivityListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final String entityType;
  final UuidValue entityGUID;
  final List<Activity> items;
  final String? errorMessage;

  ActivityListState({
    required this.entityGUID,
    this.status = ActivityListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.entityType = "",
    this.items = const [],
    this.errorMessage
  });

  factory ActivityListState.initial() {
    return ActivityListState(
      entityGUID: Uuid().zero,
    );
  }

  factory ActivityListState.withEntity(UuidValue entityGUID) {
    return ActivityListState(
      entityGUID: entityGUID,
    );
  }

  ActivityListState copyWith({
    ActivityListStatus? status,
    List<Activity>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    String? entityType,
    UuidValue? entityGUID,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return ActivityListState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        entityType: entityType ?? this.entityType,
        entityGUID: entityGUID ?? this.entityGUID,
        hasMore: hasMore ?? this.hasMore,
        items: items ?? this.items,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset
    );
  }
}