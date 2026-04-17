

import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/play/bloc/play/play_bloc.dart';
import 'package:tennisapp/modules/play/play.dart';
import 'package:tennisapp/modules/venues/venues.dart';

class PlayButton extends StatelessWidget{
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: FloatingActionButton(
        backgroundColor: Colors.brown.shade300,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        onPressed: (){
          if (!getIt.isRegistered<PlayBloc>()){
            getIt.registerLazySingleton(() => PlayBloc());
          }
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VenueList(),
          ));
        },
        child: Icon(Icons.restaurant_outlined, color: Colors.white),
      ),
    );
  }
}