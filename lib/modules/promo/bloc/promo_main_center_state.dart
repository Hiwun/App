import 'package:tennisapp/models/model.dart';

enum PromoMainCenterStatus { initial, success, failure, loading}

class PromoMainCenterState {
  final PromoMainCenterStatus status;
  final bool isLoading;
  final List<Promotion> items;
  final String? errorMessage;

  PromoMainCenterState({
    this.status = PromoMainCenterStatus.initial,
    this.isLoading = false,
    this.items = const [],
    this.errorMessage
  });

  PromoMainCenterState copyWith({
    PromoMainCenterStatus? status,
    List<Promotion>? items,
    String? errorMessage,
    bool? isLoading,
  }) {
    return PromoMainCenterState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
    );
  }
}