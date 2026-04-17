
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/play/bloc/timechecker/time_checker_bloc.dart';
import 'package:tennisapp/modules/play/components/select_time_checker.dart';
import 'package:tennisapp/modules/play/features/pickers.dart';
import 'package:tennisapp/utils/utils.dart';

import '../bloc/play/play_bloc.dart';
import '../bloc/play/play_state.dart';

class SelectTimeCourt extends StatefulWidget{
  final DateTime selectedDate;
  final TimeOfDay? selectedTimeStart;
  final TimeOfDay? selectedTimeEnd;
  const SelectTimeCourt({super.key, required this.selectedDate, this.selectedTimeStart, this.selectedTimeEnd});

  @override
  State<StatefulWidget> createState() => _SelectTimeCourtState();

}

class _SelectTimeCourtState extends State<SelectTimeCourt>{
  late TimeOfDay _selectedTimeStart;
  late TimeOfDay _selectedTimeEnd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TimeOfDay currentTime = TimeOfDay.now();
    int roundMinute = BookingTimePicker.roundMinute(currentTime.minute);
    if (widget.selectedTimeStart != null){
      _selectedTimeStart = widget.selectedTimeStart ?? TimeOfDay(hour: currentTime.hour, minute: roundMinute);
    } else {
      _selectedTimeStart = TimeOfDay(hour: currentTime.hour, minute: roundMinute);
    }
    if (widget.selectedTimeEnd != null){
      _selectedTimeEnd = widget.selectedTimeEnd ?? TimeOfDay(hour: currentTime.hour, minute: roundMinute);
    } else {
      _selectedTimeEnd = TimeOfDay(hour: currentTime.hour, minute: roundMinute);
    }
  }



  @override
  void didUpdateWidget(covariant SelectTimeCourt oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if(oldWidget.selectedTimeStart != widget.selectedTimeStart && widget.selectedTimeStart != null){
      _selectedTimeStart = widget.selectedTimeStart ?? TimeOfDay.now();
    }
    if(oldWidget.selectedTimeEnd != widget.selectedTimeEnd && widget.selectedTimeEnd != null){
      _selectedTimeEnd = widget.selectedTimeEnd ?? TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              const VerticalDivider(
                color: Colors.green,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("На какое время вы бы хотели арендовать корт?"),
                      Text(
                        "Пожалуйста, укажите начало и конец брони.",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        SizedBox(child: Text('Начало: ${TimeUtils.timeOfDayToString(_selectedTimeStart)}')),
                        const SizedBox(width: 50,),
                        SizedBox(child: Text('Конец: ${TimeUtils.timeOfDayToString(_selectedTimeEnd)}'))
                      ],
                    ),
                  ),
                  BlocProvider(
                    create: (_) => SelectTimeCheckerBloc(),
                    child: SelectPlayTimeChecker(
                      selectedTimeStart: _selectedTimeStart,
                      selectedTimeEnd: _selectedTimeEnd,
                      selectedDate: widget.selectedDate,
                    ),
                  ),
                  Text(
                    '*Выбор только по слотам',
                    softWrap: true,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
      ],
    );
  }
}