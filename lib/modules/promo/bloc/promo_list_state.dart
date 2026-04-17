import 'package:tennisapp/models/model.dart';

enum PromoListStatus { initial, success, failure, loading}

class PromoListState {
  final PromoListStatus status;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final int offset;
  final int limit;
  final List<Promotion> items;
  final String? errorMessage;

  PromoListState({
    this.status = PromoListStatus.initial,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.offset = 0,
    this.limit = 20,
    this.items = const [],
    this.errorMessage
  });

  PromoListState copyWith({
    PromoListStatus? status,
    List<Promotion>? items,
    String? errorMessage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? limit,
    int? offset,
  }) {
    return PromoListState(
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