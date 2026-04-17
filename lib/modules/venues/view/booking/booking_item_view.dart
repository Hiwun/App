import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_bloc.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_events.dart';
import 'package:tennisapp/utils/utils.dart';

class BookingItemView extends StatefulWidget {

  final bool allowViewCanceledButton;
  final Booking booking;

  final Map<String, dynamic> statuses = {
    'pending': {
      'name': 'Ожидание подтверждения',
      'color': Colors.orange,
      'icon': Icons.timelapse_outlined
    },
    'wait_accept_edit_user': {
      'name': 'Подтвердите изменения заведения',
      'color': Colors.orange,
      'icon': Icons.timelapse_outlined
    },
    'wait_accept_edit_venue': {
      'name': 'Ожидание подтверждения изменений',
      'color': Colors.orange,
      'icon': Icons.timelapse_outlined
    },
    'cancelled_user': {
      'name': 'Отменена пользователем',
      'color': Colors.red.shade300,
      'icon': Icons.cancel_outlined
    },
    'cancelled_venue': {
      'name': 'Отменена заведением',
      'color': Colors.red.shade300,
      'icon': Icons.cancel_outlined
    },
    'active': {
      'name': 'Подтверждена',
      'color': Colors.green.shade400,
      'icon': Icons.check_outlined
    },
    'finish': {
      'name': 'Завершена',
      'color': Colors.indigoAccent,
      'icon': Icons.check_outlined
    },
  };


  BookingItemView({super.key, this.allowViewCanceledButton = true, required this.booking});


  @override
  State<BookingItemView> createState() => _BookingItemViewState();
}

class _BookingItemViewState extends State<BookingItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Row(
              spacing: 4,
              children: [
                Text(
                  TimeUtils.timeOfDayToString(TimeOfDay.fromDateTime(widget.booking.startTime)),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat('d.MM, EEE').format(widget.booking.startTime),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.booking.venueName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                  ),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.person_outline, size: 18),
                    Text(
                        'На имя: ${widget.booking.guestName}'
                    )
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.location_on_outlined, size: 18),
                    Text(
                        widget.booking.venueShortAddress
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 6,
                      children: [
                        Row(
                          spacing: 2,
                          children: [
                            Icon(widget.statuses[widget.booking.status]['icon'], color: widget.statuses[widget.booking.status]['color'], size: 20),
                            Text(
                              widget.statuses[widget.booking.status]['name'],
                              style: TextStyle(
                                  color: widget.statuses[widget.booking.status]['color'],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),

            Container(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 4,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CircleAvatar(backgroundColor: Colors.grey),
                      ),
                      Text(
                          'Хостес: Алиса Иванова'
                      ),
                    ],
                  ),
                  if (widget.booking.status != 'cancelled_venue' && widget.booking.status != 'cancelled_user' && widget.booking.status != 'finish') Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){
                          getIt<BookingListBloc>().add(OnBookingListRequestCancelEvent(guid: widget.booking.guid));
                        },
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        ),
                        child: Text(
                          'Отменить',
                          style: TextStyle(
                              color: Colors.redAccent.shade400,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
