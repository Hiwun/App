import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/booking/next_event.dart';
import 'package:tennisapp/modules/booking/booking.dart';
import 'package:tennisapp/modules/booking/components/next_event_booking_info.dart';
import 'package:tennisapp/utils/utils.dart';

class NextEventCard extends StatefulWidget{
  
  final bool allowViewCanceledButton;
  final NextEvent nextEvent;

  const NextEventCard({super.key, this.allowViewCanceledButton = true, required this.nextEvent});

  @override
  State<StatefulWidget> createState() => _NextEventCardState();

}

class _NextEventCardState extends State<NextEventCard>{

  @override
  Widget build(BuildContext context) {
    return Container(
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
                TimeUtils.timeOfDayToString(TimeOfDay.fromDateTime(widget.nextEvent.startTime.toLocal())),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateFormat('d.MM, EEE').format(widget.nextEvent.startTime.toLocal()),
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          NextEventBookingInfo(
              allowViewCanceledButton: widget.allowViewCanceledButton,
              nextEvent: widget.nextEvent
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
                if (widget.nextEvent.status != 'cancelled_venue' && widget.nextEvent.status != 'cancelled_user' && widget.nextEvent.status != 'finish') Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        getIt<NextEventBloc>().add(OnNextEventRequestCancelEvent(guid: widget.nextEvent.guid));
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
    );
  }
}