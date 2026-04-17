import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingTimePicker {
  static int roundMinute (int minute){
    return  (minute ~/ 15) * 15;
  }
  static void showTimePicker (Function(TimeOfDay selectedTime) onSelectedDate, BuildContext context){

    TimeOfDay initialTime = TimeOfDay.now();
    // Округляем минуты до ближайшего кратного 15
    int roundedMinute = roundMinute(initialTime.minute);

    DateTime initialDateTime = DateTime(
        0, 1, 1, initialTime.hour, roundedMinute
    );

    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                          child: const Text('Готово'),
                          onPressed: () => Navigator.of(context).pop()
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: CupertinoDatePicker(
                    use24hFormat: true,
                    initialDateTime: initialDateTime,
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 15,
                    onDateTimeChanged: (newDateTime) => onSelectedDate(TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute)),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}