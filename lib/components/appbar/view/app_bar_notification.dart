import 'package:flutter/material.dart';
import 'package:tennisapp/modules/notification/notification.dart';

import '../../dev/view/dev_screen.dart';

class AppBarClientNotification extends StatelessWidget{
  const AppBarClientNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationListView(),
              ));
            },
            icon: Icon(Icons.notifications_outlined)
    );
  }

}