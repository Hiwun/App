import 'package:flutter/cupertino.dart';

class NextEventCardEmpty extends StatelessWidget{
  const NextEventCardEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Брони отсутствуют'),
      ),
    );
  }
}