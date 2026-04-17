import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';

class NotificationItemView extends StatefulWidget {
  final NotificationModel notification;
  const NotificationItemView({super.key, required this.notification});

  @override
  State<NotificationItemView> createState() => _NotificationItemViewState();
}

class _NotificationItemViewState extends State<NotificationItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: widget.notification.isChecked ? Colors.grey.shade200 : Colors.white
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 12),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green.shade200
                    ),
                    child: Icon(Icons.access_time, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.notification.title),
                    Text(widget.notification.description),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: Text('2 мин назад'),
            )
          ],
        ),
      ),
    );
  }
}
