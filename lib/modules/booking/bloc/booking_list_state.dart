import 'package:tennisapp/models/model.dart';

enum BookingListStatus { initial, success, failure, loading}

class BookingListState {
  final BookingListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final List<Booking> items;
  final String? errorMessage;

  BookingListState({
    this.status = BookingListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.items = const [],
    this.errorMessage
  });

  BookingListState copyWith({
    BookingListStatus? status,
    List<Booking>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return BookingListState(
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