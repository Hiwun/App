import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

enum VenueTablesAvailabilityListStatus { initial, success, failure, loading}

class VenueTablesAvailabilityListState {
  final VenueTablesAvailabilityListStatus status;
  final bool isLoading;
  final List<TableAvailability> items;
  final String? errorMessage;
  final UuidValue venueGUID;
  final DateTime? requestTime;

  VenueTablesAvailabilityListState({
    this.status = VenueTablesAvailabilityListStatus.initial,
    this.isLoading = false,
    this.requestTime,
    this.items = const [],
    this.errorMessage,
    required this.venueGUID
  });

  VenueTablesAvailabilityListState copyWith({
    VenueTablesAvailabilityListStatus? status,
    List<TableAvailability>? items,
    String? errorMessage,
    bool? isLoading,
    UuidValue? venueGUID,
    DateTime? requestTime,
  }) {
    return VenueTablesAvailabilityListState(
        status: status ?? this.status,
        requestTime: requestTime ?? this.requestTime,
        venueGUID: venueGUID ?? this.venueGUID,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
    );
  }
}