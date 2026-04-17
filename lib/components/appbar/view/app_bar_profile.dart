
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';
import 'package:tennisapp/modules/profile/profile.dart';
import 'package:tennisapp/storage/storage.dart';

class AppBarClientProfile extends StatelessWidget{
  const AppBarClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ClientProfileScreen()
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}