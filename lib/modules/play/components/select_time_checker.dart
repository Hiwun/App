import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/modules/play/bloc/timechecker/time_checker_event.dart';

import '../bloc/timechecker/time_checker_bloc.dart';
import '../bloc/timechecker/time_checker_state.dart';

class SelectPlayTimeChecker extends StatefulWidget{
  const SelectPlayTimeChecker({super.key, required this.selectedDate, required this.selectedTimeStart, required this.selectedTimeEnd});
  final DateTime selectedDate;
  final TimeOfDay selectedTimeStart;
  final TimeOfDay selectedTimeEnd;
  @override
  State<StatefulWidget> createState() => _SelectPlayTimeCheckerState();
}

class _SelectPlayTimeCheckerState extends State<SelectPlayTimeChecker>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<SelectTimeCheckerBloc>().add(SelectTimeCheckerChangeTimeEvent(widget.selectedTimeStart, widget.selectedTimeEnd, widget.selectedDate, 8));
  }

  @override
  void didUpdateWidget(covariant SelectPlayTimeChecker oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if(oldWidget.selectedTimeStart != widget.selectedTimeStart || oldWidget.selectedTimeEnd != widget.selectedTimeEnd || oldWidget.selectedDate != widget.selectedDate){
      context.read<SelectTimeCheckerBloc>().add(SelectTimeCheckerChangeTimeEvent(widget.selectedTimeStart, widget.selectedTimeEnd, widget.selectedDate, 8));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectTimeCheckerBloc, SelectTimeCheckerState>(
        builder: (context, state) {
          if(state is SelectTimeCheckerLoadingState){
            return SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(),
            );
          } else if (state is SelectTimeCheckerCheckedState && state.isAccessTime){
            return Row(
              children: [
                Icon(Icons.check, color: Colors.green),
                Text(
                  'Указанный интервал свободен ${DateFormat('EEE, d MMM y').format(widget.selectedDate)}',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Icon(Icons.close, color: Colors.red),
                Text(
                  'Указанный интервал и дата недоступны',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.red
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}