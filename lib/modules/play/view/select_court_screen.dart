import 'package:flutter/material.dart';
import 'package:tennisapp/modules/play/components/select_court_card.dart';

class SelectPlayCourtScreen extends StatelessWidget{
  SelectPlayCourtScreen({super.key});

  final courts = [
    1, 2, 3, 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Выбор корта"),
        ),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.filter_alt_sharp)
          )
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        itemCount: courts.length,
        separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(),),
        itemBuilder: (context, index) {
          final court = courts[index];
          return SelectPlayCourtCard();
        },
      ),
    );
  }
}