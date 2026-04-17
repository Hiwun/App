
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/play/bloc/play/play_bloc.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';
import 'package:tennisapp/modules/play/components/select_play_item.dart';
import 'package:tennisapp/modules/play/play.dart';

class SelectPlayTypeScreen extends StatelessWidget{
  const SelectPlayTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (result, data){
        getIt<PlayBloc>().close();
        getIt.unregister<PlayBloc>();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Выберите вариант"),
          ),
          actions: [
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.notifications_outlined)
            )
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            spacing: 10,
            children: [
              SelectPlayItem(
                  onTap: (){
                    getIt<PlayBloc>().add(PlaySelectTypeEvent(PlaySelectType.court));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectPlayCourtScreen()
                    ));
                  },
                  label: "КОРТ",
                  color: Color.fromRGBO(3, 61, 37, 1),
                  image: AssetImage("assets/images/select_court_2.png")
              ),
              SelectPlayItem(
                  onTap: (){
                    getIt<PlayBloc>().add(PlaySelectTypeEvent(PlaySelectType.time));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectPlayTimeScreen()
                    ));
                  },
                  label: "ВРЕМЯ",
                  color: Color.fromRGBO(182, 207, 177, 1),
                  image: AssetImage("assets/images/select_court_1.png")
              )
            ],
          ),
        ),
      ),
    );
  }
}