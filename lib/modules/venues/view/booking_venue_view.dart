import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_event.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_state.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';
import 'package:tennisapp/modules/venues/view/menu/menu_booking_selector_view.dart';
import 'package:tennisapp/modules/venues/view/menu/menu_item_booking_screen_view.dart';
import 'package:tennisapp/storage/storage.dart';
import 'package:uuid/uuid.dart';

import '../bloc/venue/venue_tables_availability_list_bloc.dart';
import 'hall/hall_screen.dart';

class BookingVenueView extends StatefulWidget {
  final Venue venue;
  final UuidValue? promoGUID;
  const BookingVenueView({super.key, required this.venue, this.promoGUID});

  @override
  State<BookingVenueView> createState() => _BookingVenueViewState();
}

class _BookingVenueViewState extends State<BookingVenueView> {

  late final BookingVenueBloc _bloc;
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guestCountController = TextEditingController();
  final TextEditingController _specialRequestController = TextEditingController();

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
                  Text('Помощь с заполнением', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(
                    'Заполните только минимальные данные, а мы покажем вам варианты',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Однако если вам нужно более одного стола или кол-во гостей слишком велико, придется выбрать столы вручную',
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
                        BlocBuilder<BookingVenueBloc, BookingVenueState>(
                          bloc: _bloc,
                          builder: (context, state){
                            return InkWell(
                              onTap: () => _showArrivalPicker(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Дата брони*', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                  Text(
                                      DateFormat('dd.MM, EEE - HH:mm').format(state.startTime),
                                      style: TextStyle(color: Color.fromRGBO(142,143,144, 1))
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Divider(color: Color.fromRGBO(229,231,235, 1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Кол-во гостей*', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                autocorrect: false,
                                controller: _guestCountController,
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  int v = int.tryParse(value) ?? 1;
                                  if(v < 1){
                                    v = 1;
                                  }

                                  _bloc.add(OnBookingVenueUpdateEvent(guestCount: v));
                                },
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),
                                decoration: InputDecoration(
                                  hintText: 'Кол-во гостей',
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Есть возможность забронировать', style: TextStyle(color: Color.fromRGBO(57,194,125, 1), fontWeight: FontWeight.w500)),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                        ),
                        child: Text(
                          'Подобрать',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  void _showArrivalPicker(BuildContext context) {

    DateTime resultDate = _bloc.state.startTime;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                minuteInterval: 15,
                minimumDate: _initialDate,
                maximumDate: _initialDate.add(Duration(days: 7)),
                use24hFormat: true,
                initialDateTime: _bloc.state.startTime,
                onDateTimeChanged: (newDate) {
                  resultDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    ).then((value){

      getIt<VenueTablesAvailabilityListBloc>().add(OnVenueTablesAvailabilityListRefreshEvent(venueGUID: _bloc.state.venueGUID, requestTime: resultDate));

      final dif = _bloc.state.expectedEndTime.difference(_bloc.state.startTime);

      List<BookingTable> newTables = const [];

      for (final table in _bloc.state.tables) {
        final List<TableAvailability> tableAvailabilities = getIt<
            VenueTablesAvailabilityListBloc>().state.items.where((
            item) => item.tableGUID == table.tableGUID).toList();

        if (tableAvailabilities.any((item) {
          final itemStart = item.startTime.toLocal();
          final itemEnd = item.endTime.toLocal();
          final bookingStart = resultDate.toLocal();
          final bookingEnd = resultDate.add(dif).toLocal();

          return (itemStart.isBefore(bookingStart) || itemStart
              .isAtSameMomentAs(bookingStart)) &&
              (itemEnd.isAfter(bookingEnd) || itemEnd
                  .isAtSameMomentAs(bookingEnd));
        })) {
          newTables = [...newTables, table];
        }
      }


      _bloc.add(OnBookingVenueUpdateEvent(tables: newTables, startTime: resultDate, expectedEndTime: resultDate.add(dif)));
    });
  }

  void _showDurationPicker(BuildContext context) {
    // Вычисляем текущую продолжительность
    final currentDuration = _bloc.state.expectedEndTime.difference(_bloc.state.startTime);
    final currentMinutes = currentDuration.inMinutes;
    final currentIndex = (currentMinutes ~/ 30) - 1;

    int resultMinutes = currentMinutes;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Expanded(
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: currentIndex.clamp(0, 11)),
            onSelectedItemChanged: (index) {
              final minutes = (index + 1) * 30;

              resultMinutes = minutes;
            },
            children: List.generate(12, (index) {
              final minutes = (index + 1) * 30;
              final hours = minutes ~/ 60;
              final remainingMinutes = minutes % 60;

              String text;
              if (hours == 0) {
                text = '30 минут';
              } else if (remainingMinutes == 0) {
                text = hours == 1 ? '1 час' : hours > 4 ? '$hours часов' : '$hours часа';
              } else {
                text = hours == 1 ? '1 час 30 минут' : hours > 4 ? '$hours часов 30 минут' : '$hours часа 30 минут';
              }

              return Center(
                child: Text(text),
              );
            }),
          ),
        ),
      ),
    ).then((value) {
      List<BookingTable> newTables = const [];

      for (final table in _bloc.state.tables) {
        final List<TableAvailability> tableAvailabilities = getIt<
            VenueTablesAvailabilityListBloc>().state.items.where((
            item) => item.tableGUID == table.tableGUID).toList();

        if (tableAvailabilities.any((item) {
          final itemStart = item.startTime.toLocal();
          final itemEnd = item.endTime.toLocal();
          final bookingStart = _bloc.state.startTime.toLocal();
          final bookingEnd = _bloc.state.startTime.add(Duration(minutes: resultMinutes)).toLocal();

          return (itemStart.isBefore(bookingStart) || itemStart
              .isAtSameMomentAs(bookingStart)) &&
              (itemEnd.isAfter(bookingEnd) || itemEnd
                  .isAtSameMomentAs(bookingEnd));
        })) {
          newTables = [...newTables, table];
        }
      }

      _bloc.add(OnBookingVenueUpdateEvent(tables: newTables, expectedEndTime: _bloc.state.startTime.add(Duration(minutes: resultMinutes))));
    });
  }

  void _showSpecialRequestSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.grey.shade100
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Заголовок
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Специальный запрос',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Готово'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Текстовое поле
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CupertinoTextField(
                controller: _specialRequestController,
                placeholder: 'Введите ваши пожелания...',
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                textInputAction: TextInputAction.done,
                padding: const EdgeInsets.all(12),
                onChanged: (value) {
                  _bloc.add(OnBookingVenueUpdateEvent(specialRequest: value));
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getIt<VenueTablesAvailabilityListBloc>().add(OnVenueTablesAvailabilityListRefreshEvent(venueGUID: widget.venue.guid, requestTime: _initialDate));

    final User? user = getIt<UserStorage>().user;
    _phoneController.text = user?.phone ?? "";
    _nameController.text = "Руслан";
    _guestCountController.text = "2";

    _bloc = BookingVenueBloc()
      ..add(OnBookingVenueInitialEvent(
        guid: Uuid().v4obj(),
        venueGUID: widget.venue.guid,
        userGUID: user?.guid ?? Uuid().v4obj(),
        promoGUID: widget.promoGUID,
        startTime: _initialDate,
        expectedEndTime: _initialDate.add(const Duration(hours: 2)),
      ));
    if (!getIt.isRegistered<BookingVenueBloc>()){
      getIt.registerLazySingleton(() => _bloc);
    }

  }

  @override
  void dispose() {
    _bloc.close();
    _guestCountController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _specialRequestController.dispose();
    getIt.unregister<BookingVenueBloc>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Back button
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
                        SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Бронирование',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Заполните информацию о брони',
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
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    BlocBuilder<BookingVenueBloc, BookingVenueState>(
                      bloc: _bloc,
                      builder: (context, state){
                        final currentDuration= _bloc.state.expectedEndTime.difference(_bloc.state.startTime);
                        final minutes = currentDuration.inMinutes;
                        final hours = minutes ~/ 60;
                        final remainingMinutes = minutes % 60;

                        String text;
                        if (hours == 0) {
                          text = '30 минут';
                        } else if (remainingMinutes == 0) {
                          String hoursText = hours.hoursWord;
                          text = '$hours $hoursText';
                        } else {
                          String hoursText = hours.hoursWord;
                          text = '$hours $hoursText 30 минут';
                        }

                        if(state.status == BookingVenueStatus.loading){
                          return Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

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
                                      InkWell(
                                        onTap: () => _showArrivalPicker(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Дата брони*', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                            Text(
                                                DateFormat('dd.MM, EEE - HH:mm').format(_bloc.state.startTime),
                                                style: TextStyle(color: Color.fromRGBO(142,143,144, 1))
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => HallPainterScreen()
                                          ));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Столы*', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                            Text('Выбрать', style: TextStyle(color: Color.fromRGBO(142,143,144, 1))),
                                          ],
                                        ),
                                      ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Имя гостя*', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: TextField(
                                              autocorrect: false,
                                              controller: _nameController,
                                              onChanged: (value){
                                                _bloc.add(OnBookingVenueUpdateEvent(guestName: value));
                                              },
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),
                                              decoration: InputDecoration(
                                                hintText: 'Введите имя',
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Кол-во гостей', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: TextField(
                                              autocorrect: false,
                                              controller: _guestCountController,
                                              onChanged: (value){
                                                int v = int.tryParse(value) ?? 1;
                                                if(v < 1){
                                                  v = 1;
                                                }

                                                _bloc.add(OnBookingVenueUpdateEvent(guestCount: v));
                                              },
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),
                                              decoration: InputDecoration(
                                                hintText: 'Введите кол-во',
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Телефон для связи', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: TextField(
                                              autocorrect: false,
                                              controller: _phoneController,
                                              onChanged: (value){
                                                _bloc.add(OnBookingVenueUpdateEvent(guestName: value));
                                              },
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),
                                              decoration: InputDecoration(
                                                hintText: 'Введите телефон',
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      InkWell(
                                        onTap: () => _showDurationPicker(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Продолжительность', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                            Text(text, style: TextStyle(color: Color.fromRGBO(142,143,144, 1))),
                                          ],
                                        ),
                                      ),
                                      // В след релизах
                                      // const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      // InkWell(
                                      //   onTap: (){
                                      //     Navigator.of(context).push(MaterialPageRoute(
                                      //         builder: (context) => MenuBookingSelectorView()
                                      //     ));
                                      //   },
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text('Меню', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                      //       Text('Редактировать', style: TextStyle(color: Color.fromRGBO(142,143,144, 1))),
                                      //     ],
                                      //   ),
                                      // ),
                                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                                      InkWell(
                                        onTap: () => _showSpecialRequestSheet(context),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Дополнительная информация', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                            Text(
                                              _bloc.state.specialRequest.isEmpty ? 'Не указано' : _bloc.state.specialRequest,
                                              style: const TextStyle(fontSize: 14, color: Color.fromRGBO(142,143,144, 1)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if(state.tables.isNotEmpty)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Выбранные столы',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 8,
                                        children: state.tables.map((element) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                              color: Colors.grey.shade100
                                          ),
                                          child: Text(element.title, style: TextStyle(fontWeight: FontWeight.w600),),
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                if(state.menuItems.isNotEmpty)
                                  Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Выбранное меню',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 245,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) => const SizedBox(width: 15),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.menuItems.length,
                                          itemBuilder: ((context, index) {
                                            var item = state.menuItems[index];
                                            return MenuItemBookingScreenView(
                                              item: item,
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 30),
                                if(state.status != BookingVenueStatus.success)
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _bloc.add(OnBookingVenueSendEvent());
                                          },
                                          style: ButtonStyle(

                                              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1))
                                          ),
                                          child: Text(

                                            'Забронировать',
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                if(state.status == BookingVenueStatus.failure)
                                  Wrap(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        state.errorMessage ?? "Ошибка бронирования",
                                        style: TextStyle(
                                            color: Colors.red.shade300,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      )
                                    ],
                                  ),
                                if(state.status == BookingVenueStatus.success)
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(

                                    ),
                                    child: Row(
                                      spacing: 2,
                                      children: [
                                        Icon(Icons.check, size: 24, color: Colors.green.shade400,),
                                        Text(
                                          'Успешно забронировано, вернитесь на главную страницу и ожидайте подтверждения',
                                          style: TextStyle(
                                              color: Colors.green.shade400,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension IntExtension on int {
  String get hoursWord {
    if (this % 100 >= 11 && this % 100 <= 14) {
      return 'часов';
    }

    switch (this % 10) {
      case 1: return 'час';
      case 2:
      case 3:
      case 4: return 'часа';
      default: return 'часов';
    }
  }
}
