
import 'package:uuid/uuid_value.dart';

abstract class VenueTablesAvailabilityListEvent {
  final UuidValue venueGUID;
  final DateTime? requestTime;

  VenueTablesAvailabilityListEvent({required this.venueGUID, this.requestTime});
}

class OnVenueTablesAvailabilityListInitialEvent extends VenueTablesAvailabilityListEvent {
  OnVenueTablesAvailabilityListInitialEvent({required super.venueGUID, super.requestTime});
}
class OnVenueTablesAvailabilityListRefreshEvent extends VenueTablesAvailabilityListEvent {
  OnVenueTablesAvailabilityListRefreshEvent({required super.venueGUID, super.requestTime});
}