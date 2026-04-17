import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/play/bloc/play/play_bloc.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';
import 'package:tennisapp/modules/play/play.dart';

import '../components/select_horizontal_date_selector.dart';


class SelectPlayTimeScreen extends StatefulWidget{
  const SelectPlayTimeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectPlayTimeScreenState();
}
class _SelectPlayTimeScreenState extends State<SelectPlayTimeScreen>{


  late TimeOfDay _selectedTimeStart;
  late TimeOfDay _selectedTimeEnd;
  DateTime _selectedDate = DateTime.now();


  @override
  void initState() {
    super.initState();

    TimeOfDay currentTime = TimeOfDay.now();
    int roundMinute = BookingTimePicker.roundMinute(currentTime.minute);
    _selectedTimeStart = TimeOfDay(hour: currentTime.hour, minute: roundMinute);
    _selectedTimeEnd = TimeOfDay(hour: currentTime.hour, minute: roundMinute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Выбор времени"),
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.notifications_outlined)
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectHorizontalDateSelector(
              initialDate: _selectedDate,
              onChangeSelectedDate: (date){
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
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
                  SizedBox(
                    child: InkWell(
                      onTap: () => BookingTimePicker.showTimePicker((newTime) => setState(() => _selectedTimeStart = newTime), context),
                      child: Row(
                        spacing: 2,
                        children: [
                          Text('Начало:'),
                          Text('${_selectedTimeStart.hour.toString().padLeft(2, '0')}:${(_selectedTimeStart.minute.toString().padLeft(2, '0'))}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 50,),
                  SizedBox(
                    child: InkWell(
                      onTap: () => BookingTimePicker.showTimePicker((newTime) => setState(() => _selectedTimeEnd = newTime), context),
                      child: Row(
                        spacing: 2,
                        children: [
                          Text('Конец:'),
                          Text('${_selectedTimeEnd.hour.toString().padLeft(2, '0')}:${_selectedTimeEnd.minute.toString().padLeft(2, '0')}'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  getIt<PlayBloc>().add(PlaySelectTimeEvent(_selectedDate, _selectedTimeStart, _selectedTimeEnd));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  SelectPlayCourtScreen(),
                      settings: RouteSettings(
                          arguments: 'select_time'
                      )
                  ));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(149, 255, 92, 1))
                ),
                child: Text(
                  'Выбрать корт',
                  style: TextStyle(
                    color: Colors.black
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}