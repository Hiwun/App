import 'package:tennisapp/models/model.dart';

enum VenueListStatus { initial, success, failure, loading}

class VenueListState {
  final VenueListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final List<Venue> items;
  final String? errorMessage;

  VenueListState({
    this.status = VenueListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.items = const [],
    this.errorMessage
  });

  VenueListState copyWith({
    VenueListStatus? status,
    List<Venue>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return VenueListState(
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