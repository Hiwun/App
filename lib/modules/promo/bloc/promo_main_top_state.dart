import 'package:tennisapp/models/model.dart';

enum PromoMainTopStatus { initial, success, failure, loading}

class PromoMainTopState {
  final PromoMainTopStatus status;
  final bool isLoading;
  final List<Promotion> items;
  final String? errorMessage;

  PromoMainTopState({
    this.status = PromoMainTopStatus.initial,
    this.isLoading = false,
    this.items = const [],
    this.errorMessage
  });

  PromoMainTopState copyWith({
    PromoMainTopStatus? status,
    List<Promotion>? items,
    String? errorMessage,
    bool? isLoading,
  }) {
    return PromoMainTopState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
    );
  }
}