import 'package:flutter/cupertino.dart' hide Table;
import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_state.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_state.dart';

class HallTablesAvailableInfoView extends StatefulWidget {
  const HallTablesAvailableInfoView({super.key});

  @override
  State<HallTablesAvailableInfoView> createState() => _HallTablesAvailableInfoViewState();
}

class _HallTablesAvailableInfoViewState extends State<HallTablesAvailableInfoView> {
  DateTime get _initialDate {
    final now = DateTime.now();
    final minute = now.minute;
    final roundedMinute = (minute / 15).round() * 15;
    return DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      roundedMinute,
    );
  }

  late final VenueHallListBloc _venueHallListBloc;
  final TransformationController _controller = TransformationController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _venueHallListBloc = getIt<VenueHallListBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showModalHelper () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
              ),
              child: Column(
                children: [
                  Text('Изменение даты просмотра', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(
                    'Выберите дату просмотра, а мы запросим данные у заведения',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250,249,251, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                          bloc: getIt<VenueTablesAvailabilityListBloc>(),
                          builder: (context, state){
                            return InkWell(
                              onTap: () => _showArrivalPicker(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Дата', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                  Text(
                                      DateFormat('dd.MM, EEE').format(state.requestTime ?? _initialDate),
                                      style: TextStyle(color: Color.fromRGBO(142,143,144, 1))
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showArrivalPicker(BuildContext context) {

    final bloc = getIt<VenueTablesAvailabilityListBloc>();
    DateTime resultDate = bloc.state.requestTime ?? _initialDate;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minuteInterval: 15,
                minimumDate: _initialDate,
                maximumDate: _initialDate.add(Duration(days: 7)),
                use24hFormat: true,
                initialDateTime: bloc.state.requestTime ?? _initialDate,
                onDateTimeChanged: (newDate) {
                  resultDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    ).then((value){

      bloc.add(OnVenueTablesAvailabilityListRefreshEvent(venueGUID: bloc.state.venueGUID, requestTime: resultDate));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // Back button
                    if (Navigator.of(context).canPop() == true)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.grey[700], size: 20),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    if (Navigator.of(context).canPop() == true)
                      SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Занятость зала',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                            bloc: getIt<VenueTablesAvailabilityListBloc>(),
                            builder: (context, state){
                              return Text(
                                DateFormat('dd.MM, EEE').format(state.requestTime ?? _initialDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Выберите зону, мы покажем вам свободное время',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 42,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(57,194,125, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showModalHelper();

                        },
                        icon: Icon(Icons.help_center_outlined, color: Colors.white, size: 22),
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<VenueHallListBloc, VenueHallListState>(
                  bloc: _venueHallListBloc,
                  builder: (context, state){
                    int i = 0;
                    return Wrap(
                      runSpacing: 8,
                      spacing: 5,
                      children: state.items.map((hall){
                        int currIndex = i;
                        i++;
                        return InkWell(
                          onTap: (){
                            setState(() {
                              _currentIndex = currIndex;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                color: _currentIndex == currIndex ? Colors.grey.shade200 : Colors.transparent
                            ),
                            child: Text(hall.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              BlocBuilder<VenueHallListBloc, VenueHallListState>(
                bloc: _venueHallListBloc,
                builder: (context, state){

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: state.items[_currentIndex].tables.map((table) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    table.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                                bloc: getIt<VenueTablesAvailabilityListBloc>(),
                                builder: (context, tablesState){
                                  final tablesAvailability = tablesState.items.where((item) => item.tableGUID == table.guid).toList();
                                  return Wrap(
                                    spacing: 10,
                                    runSpacing: 8,
                                    children: tablesAvailability.map((element) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          color: Colors.grey.shade100
                                      ),
                                      child: Text("${DateFormat("HH:mm").format(element.startTime.toLocal())} - ${DateFormat("HH:mm").format(element.endTime.toLocal())}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),),
                                    )).toList(),
                                  );
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        )
    );
  }
}
