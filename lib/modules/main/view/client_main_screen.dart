import 'package:flutter/material.dart';
import 'package:tennisapp/components/bottom_navigation/bottom_navigation.dart';
import 'package:tennisapp/modules/main/main.dart';
import 'package:tennisapp/modules/profile/profile.dart';
import 'package:tennisapp/modules/promo/promo.dart';
import 'package:tennisapp/modules/property/view/property_list.dart';

class ClientMainScreen extends StatefulWidget{
  const ClientMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ClientMainScreenState();
}
class _ClientMainScreenState extends State<ClientMainScreen>{
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    PromoListView(),
    PropertyList(),
    ClientProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClientBottomNavigation(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex
      ),
    );
  }
}

