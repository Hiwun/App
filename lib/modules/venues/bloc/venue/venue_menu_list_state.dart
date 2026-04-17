import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid_value.dart';

enum VenueMenuListStatus { initial, success, failure, loading}

class VenueMenuListState {
  final VenueMenuListStatus status;
  final bool isLoading;
  final List<MenuCategory> items;
  final UuidValue venueGUID;
  final String? errorMessage;
  final DateTime? requestTime;

  VenueMenuListState({
    this.status = VenueMenuListStatus.initial,
    this.isLoading = false,
    this.requestTime,
    required this.venueGUID,
    this.items = const [],
    this.errorMessage
  });

  VenueMenuListState copyWith({
    VenueMenuListStatus? status,
    List<MenuCategory>? items,
    String? errorMessage,
    UuidValue? venueGUID,
    bool? isLoading,
    DateTime? requestTime,
  }) {
    return VenueMenuListState(
        status: status ?? this.status,
        requestTime: requestTime ?? this.requestTime,
        venueGUID: venueGUID ?? this.venueGUID,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
    );
  }
}