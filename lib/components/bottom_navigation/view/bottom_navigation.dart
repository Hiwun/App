import 'package:flutter/material.dart';


class ClientBottomNavigation extends StatelessWidget{
  final int currentIndex;
  final ValueChanged<int> onTap;
  const ClientBottomNavigation({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      child: BottomNavigationBar(
        enableFeedback: false,
        iconSize: 18,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        backgroundColor: Color.fromRGBO(250,249,251, 1),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Color.fromRGBO(169,179,193, 1)),
            activeIcon: Icon(Icons.home_outlined, color: Colors.black),
            label: "Главная",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_outlined, color: Color.fromRGBO(169,179,193, 1)),
              activeIcon: Icon(Icons.discount_outlined, color: Colors.black),
              label: "Акции"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_restaurant_outlined, color: Color.fromRGBO(169,179,193, 1)),
              activeIcon: Icon(Icons.table_restaurant_outlined, color: Colors.black),
              label: "Заведения"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Color.fromRGBO(169,179,193, 1)),
              activeIcon: Icon(Icons.person_outline, color: Colors.black),
              label: "Профиль"
          ),
        ],
      ),
    );
  }
}