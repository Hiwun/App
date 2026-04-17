
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/play/bloc/play/play_bloc.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';
import 'package:tennisapp/modules/play/components/select_horizontal_date_selector.dart';
import 'package:tennisapp/modules/play/components/select_time_court.dart';
import 'package:tennisapp/modules/play/view/select_booking_confirm_screen.dart';
import 'package:tennisapp/utils/utils.dart';

class SelectTimeBookingScreen extends StatefulWidget{
  const SelectTimeBookingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectTimeBookingScreenState();
}

class _SelectTimeBookingScreenState extends State<SelectTimeBookingScreen>{
  DateTime _selectedDate = DateTime.now();

  bool _requireTrainer = false;
  TimeOfDay? _selectedTimeStart;
  TimeOfDay? _selectedTimeEnd;



  // List<BookingSlot> slots = [
  //   BookingSlot(startTime: TimeOfDay(hour: 10, minute: 00), endTime: TimeOfDay(hour: 11, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 11, minute: 00), endTime: TimeOfDay(hour: 12, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 12, minute: 00), endTime: TimeOfDay(hour: 13, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 13, minute: 00), endTime: TimeOfDay(hour: 14, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 14, minute: 00), endTime: TimeOfDay(hour: 15, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 15, minute: 00), endTime: TimeOfDay(hour: 16, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 16, minute: 00), endTime: TimeOfDay(hour: 17, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 17, minute: 00), endTime: TimeOfDay(hour: 18, minute: 00)),
  //   BookingSlot(startTime: TimeOfDay(hour: 18, minute: 00), endTime: TimeOfDay(hour: 19, minute: 00)),
  // ];

  void _showSelectRequiredTrainerModal() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Нужен ли вам тренер'),
        message: const Text('Нажмите на один из вариантов ниже'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _requireTrainer = true;
              });
              Navigator.pop(context);
            },
            child: const Text('Да'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _requireTrainer = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Нет'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: const Text('Отмена'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Формирование брони"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            SelectTimeCourt(
              selectedDate: _selectedDate,
              selectedTimeEnd: _selectedTimeEnd,
              selectedTimeStart: _selectedTimeStart,
            ),
            // InkWell(
            //   onTap: () => _showSelectRequiredTrainerModal(),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //               'Потребуется ли вам тренер?'
            //           ),
            //           Text(_requireTrainer
            //               ? 'Да'
            //               : 'Нет'
            //           )
            //         ],
            //       ),
            //       Icon(Icons.keyboard_arrow_right_outlined)
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 8),
            // const Divider(),
            // const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              // children: slots.map((slot) => InkWell(
              //   onTap: (){
              //     setState(() {
              //       _selectedTimeStart = slot.startTime;
              //       _selectedTimeEnd = slot.endTime;
              //     });
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey),
              //         borderRadius: BorderRadius.all(Radius.circular(8))
              //     ),
              //     child: Text('${TimeUtils.timeOfDayToString(slot.startTime)} - ${TimeUtils.timeOfDayToString(slot.endTime)}'),
              //   ),
              // )).toList(),
            ),

            const SizedBox(height: 8),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  getIt<PlayBloc>().add(PlaySelectBookingInformationEvent(_selectedDate, _selectedTimeStart ?? TimeOfDay.now(), _selectedTimeEnd ?? TimeOfDay.now(), _requireTrainer));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectBookingConfirmScreen()));
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(149, 255, 92, 1))
                ),
                child: Text(
                  'Подтвердить',
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