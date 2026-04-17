import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/booking/booking.dart';
import 'package:tennisapp/modules/main/components/home_current_booking.dart';
import 'package:tennisapp/modules/main/components/home_information.dart';
import 'package:tennisapp/modules/notification/notification.dart';
import 'package:tennisapp/modules/profile/profile.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Приветствуем',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Руслан',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ClientProfileScreen()
                      ));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.person_outline, color: Colors.grey.shade700,),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(57,194,125, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationListView()
                        ));
                      },
                      icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  if(getIt.isRegistered<NextEventBloc>()){
                    final bloc = getIt<NextEventBloc>();
                    bloc.add(NextEventOnInitializedEvent());
                  }
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      HomeInformation(),
                      HomeCurrentBooking(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}