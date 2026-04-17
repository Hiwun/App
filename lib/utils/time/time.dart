import 'package:flutter/material.dart';

class TimeUtils {
  static TimeOfDay parseDurationToTimeOfDay(int nanoseconds) {
    final totalMinutes = nanoseconds ~/ Duration.microsecondsPerMinute ~/ 1000;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }
  static int timeOfDayToNanoseconds(TimeOfDay tod) {
    // 1 час = 3 600 секунд, 1 минута = 60 секунд, 1 секунда = 1e9 наносекунд
    const int nsPerSecond = 1000000000;
    final totalSeconds = tod.hour * Duration.secondsPerHour + tod.minute * Duration.secondsPerMinute;
    return totalSeconds * nsPerSecond;
  }
  static String timeOfDayToString(TimeOfDay? tod) {
   if(tod == null){
     return "";
   }
   return '${tod.hour.toString().padLeft(2, '0')}:${tod.minute.toString().padLeft(2, '0')}';
  }
}