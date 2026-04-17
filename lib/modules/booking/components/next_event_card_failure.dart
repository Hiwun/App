import 'package:flutter/cupertino.dart';

class NextEventCardFailure extends StatelessWidget{
  const NextEventCardFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Ошибка загрузки брони'),
      ),
    );
  }
}