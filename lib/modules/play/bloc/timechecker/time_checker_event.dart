import 'package:flutter/material.dart';

abstract class SelectTimeCheckerEvent{}

class SelectTimeCheckerChangeTimeEvent extends SelectTimeCheckerEvent{

  final DateTime selectedDate;
  final int courtId;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;

  SelectTimeCheckerChangeTimeEvent(this.selectedTimeStart, this.selectedTimeEnd, this.selectedDate, this.courtId);

}