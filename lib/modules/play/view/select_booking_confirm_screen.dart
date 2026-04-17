import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/booking/booking.dart';
import 'package:tennisapp/modules/play/view/select_booking_sending_screen.dart';
import 'package:uuid/uuid.dart';

class SelectBookingConfirmScreen extends StatelessWidget{
  const SelectBookingConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подтверждение брони'),
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Информация о брони',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                    'Проверьте информацию перед подтверждением'
                ),
              ],
            ),
            NextEventCard(
              allowViewCanceledButton: false,
              nextEvent: NextEvent(
                guid: Uuid().v4obj(),
                userGUID: Uuid().v4obj(),
                venueGUID: Uuid().v4obj(),
                venueName: 'Ресторан Сказка',
                venueShortAddress: 'Свободы 34',
                guestName: 'Руслан',
                startTime: DateTime.now(),
                status: 'active',
                guestCount: 4,
                performedByGUID: Uuid().v4obj(),
                performedByName: 'Алина хостес',
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectBookingSendingScreen())),
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