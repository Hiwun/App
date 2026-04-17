import 'package:flutter/material.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';

abstract class PlayState{}

class PlayInitialState extends PlayState{}

class PlaySelectTypeState extends PlayState{
  final PlaySelectType type;
  PlaySelectTypeState(this.type);
}

class PlaySelectTimeState extends PlayState{

  final PlaySelectType type;
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  PlaySelectTimeState(this.type, this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd);
}
class PlaySelectCourtState extends PlayState{

  final bool allowSelectedFreeTime;
  final PlaySelectType type;
  //final Court court;
  PlaySelectCourtState(this.type, this.allowSelectedFreeTime);
}
class PlaySelectCourtAfterTimeState extends PlayState{

  final PlaySelectType type;
  //final Court court;
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  PlaySelectCourtAfterTimeState(this.type, this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd);
}
class PlaySelectTrainerState extends PlayState{

  final PlaySelectType type;
  //final Court court;
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  final bool requireTrainer;
  PlaySelectTrainerState(this.type, this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd, this.requireTrainer, );
}
class PlaySelectBookingInformationState extends PlayState{
  final PlaySelectType type;
  //final Court court;
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  final bool requireTrainer;
  final bool allowSelectedFreeTime;

  PlaySelectBookingInformationState(this.type, this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd, this.requireTrainer,  this.allowSelectedFreeTime);
}