import 'package:flutter/material.dart';

import '../../../../models/model.dart';

abstract class PlayEvent{}

class PlaySelectTypeEvent extends PlayEvent{
  final PlaySelectType type;
  PlaySelectTypeEvent(this.type);
}
class PlaySelectCourtEvent extends PlayEvent{
  //final Court court;
  //PlaySelectCourtEvent(this.court);
}
class PlaySelectTimeEvent extends PlayEvent{
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;

  PlaySelectTimeEvent(this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd);
}
class PlaySelectTrainerEvent extends PlayEvent{
  final bool requireTrainer;

  PlaySelectTrainerEvent(this.requireTrainer);
}

class PlaySelectBookingInformationEvent extends PlayEvent{
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  final bool requireTrainer;

  PlaySelectBookingInformationEvent(this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd, this.requireTrainer);
}

enum PlaySelectType {
  court,
  time
}