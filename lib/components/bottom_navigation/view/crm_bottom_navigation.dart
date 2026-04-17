import 'package:flutter/material.dart';

class CrmBottomNavigation extends StatefulWidget{
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CrmBottomNavigation({super.key, required this.onTap, required this.currentIndex});

  @override
  State<StatefulWidget> createState() => _CrmBottomNavigationState();
}

class _CrmBottomNavigationState extends State<CrmBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: BottomNavigationBar(
        iconSize: 26,
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        backgroundColor: Colors.white,
        onTap: widget.onTap,
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),

            label: "Журнал",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "Клиенты"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: "График"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: "Уведомления"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              label: "Еще"
          ),
        ],
      ),
    );
  }
}