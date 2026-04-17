import 'package:flutter/material.dart';

abstract class SelectTimeCheckerState{}

class SelectTimeCheckerInitialState extends SelectTimeCheckerState{}
class SelectTimeCheckerLoadingState extends SelectTimeCheckerState{}
class SelectTimeCheckerCheckedState extends SelectTimeCheckerState{
  final bool isAccessTime;
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;

  SelectTimeCheckerCheckedState(this.isAccessTime, this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd);

}

