
import 'package:uuid/uuid.dart';

abstract class VenueHallListEvent {
  final UuidValue venueGUID;

  VenueHallListEvent({required this.venueGUID});
}

class OnVenueHallListInitialEvent extends VenueHallListEvent {
  OnVenueHallListInitialEvent({required super.venueGUID});
}
class OnVenueHallListRefreshEvent extends VenueHallListEvent {
  OnVenueHallListRefreshEvent({required super.venueGUID});
}