import 'package:flutter/material.dart';
import 'package:tennisapp/components/bottom_navigation/view/crm_bottom_navigation.dart';

import '../../../components/appbar/view/app_bar_notification.dart';
import '../../../components/appbar/view/app_bar_profile.dart';
import '../../../components/dev/view/dev_screen.dart';

class CrmMainScreen extends StatefulWidget{
  const CrmMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CrmMainScreenState();
}
class _CrmMainScreenState extends State<CrmMainScreen>{
  int _currentIndex = 0;
  final List<Widget> _screens = [
    DevScreenInfo(),
    DevScreenInfo(),
    DevScreenInfo(),
    DevScreenInfo(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CrmBottomNavigation(
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