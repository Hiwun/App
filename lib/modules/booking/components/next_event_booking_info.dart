import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/utils/utils.dart';

class NextEventBookingInfo extends StatefulWidget{

  final bool allowViewCanceledButton;
  final NextEvent nextEvent;

  final Map<String, dynamic> statuses = {
    'pending': {
      'name': 'Ожидание',
      'color': Colors.orange,
      'icon': Icons.timelapse_outlined
    },
    'wait_accept_edit_user': {
      'name': 'Ожидание подтверждения пользователя',
      'color': Colors.orange,
      'icon': Icons.timelapse_outlined
    },
    'wait_accept_edit_venue': {
      'name': 'Ожидание подтверждения заведения',
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

  NextEventBookingInfo({super.key, this.allowViewCanceledButton = true, required this.nextEvent});

  @override
  State<StatefulWidget> createState() => _NextEventBookingInfoState();

}

class _NextEventBookingInfoState extends State<NextEventBookingInfo>{


  Booking? _booking;

  @override
  void initState() {
    super.initState();
    _loadBooking();
  }

  Future<void> _loadBooking() async {
    try{
      //final booking = await getIt<BookingService>().getBookingById(widget.nextEvent.id);
      setState(() {
        //_booking = booking;
      });
    } catch (e){
      _booking = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.nextEvent.venueName,
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
                'На имя: ${widget.nextEvent.guestName}'
            )
          ],
        ),
        Row(
          spacing: 4,
          children: [
            Icon(Icons.location_on_outlined, size: 18),
            Text(
                widget.nextEvent.venueShortAddress
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
                    Icon(widget.statuses[widget.nextEvent.status]['icon'], color: widget.statuses[widget.nextEvent.status]['color'], size: 20),
                    Text(
                      widget.statuses[widget.nextEvent.status]['name'],
                      style: TextStyle(
                          color: widget.statuses[widget.nextEvent.status]['color'],
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
    );
  }

}