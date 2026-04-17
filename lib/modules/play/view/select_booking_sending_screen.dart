import 'package:flutter/material.dart';

class SelectBookingSendingScreen extends StatelessWidget{
  const SelectBookingSendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Завершение бронирования'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          spacing: 25,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Color.fromRGBO(182, 207, 177, 1),
                borderRadius: BorderRadius.all(Radius.circular(12))

              ),
              child: Column(
                spacing: 4,
                children: [
                  Icon(Icons.check, size: 50, color: Colors.white),
                  Text(
                    'ВАША ЗАПИСЬ УСПЕШНО СОЗДАНА!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'Следите за статусом брони в личном кабинете, кнопка “оплатить” появится после обработки брони, обычно это занимает не больше 5 минут!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
                child: Text('Вернуться на главную')
            )
          ],
        ),
      ),
    );
  }
}