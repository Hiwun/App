
import 'package:uuid/uuid_value.dart';

abstract class VenueMenuListEvent {
  final UuidValue venueGUID;
  final DateTime? requestTime;

  VenueMenuListEvent({required this.venueGUID, this.requestTime});
}

class OnVenueMenuListInitialEvent extends VenueMenuListEvent {
  OnVenueMenuListInitialEvent({required super.venueGUID});
}
class OnVenueMenuListRefreshEvent extends VenueMenuListEvent {
  OnVenueMenuListRefreshEvent({required super.venueGUID});
}