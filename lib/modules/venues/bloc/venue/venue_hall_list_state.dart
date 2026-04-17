import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

enum VenueHallListStatus { initial, success, failure, loading}

class VenueHallListState {
  final VenueHallListStatus status;
  final bool isLoading;
  final UuidValue venueGUID;
  final List<VenueZone> items;
  final String? errorMessage;

  VenueHallListState({
    this.status = VenueHallListStatus.initial,
    this.isLoading = false,
    required this.venueGUID,
    this.items = const [],
    this.errorMessage
  });

  VenueHallListState copyWith({
    VenueHallListStatus? status,
    List<VenueZone>? items,
    UuidValue? venueGUID,
    String? errorMessage,
    bool? isLoading,
  }) {
    return VenueHallListState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      venueGUID: venueGUID ?? this.venueGUID
    );
  }
}