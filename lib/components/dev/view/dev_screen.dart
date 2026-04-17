

import 'package:flutter/material.dart';

class DevScreenInfo extends StatelessWidget{
  const DevScreenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Модуль Х'),
      ),
      body: Center(
        child: Text('Модуль в разработке'),
      ),
    );
  }
}