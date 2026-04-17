import 'package:tennisapp/models/model.dart';

enum NotificationListStatus { initial, success, failure, loading}

class NotificationListState {
  final NotificationListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final List<NotificationModel> items;
  final String? errorMessage;

  NotificationListState({
    this.status = NotificationListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.items = const [],
    this.errorMessage
  });

  NotificationListState copyWith({
    NotificationListStatus? status,
    List<NotificationModel>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return NotificationListState(
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