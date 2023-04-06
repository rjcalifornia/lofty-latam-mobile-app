// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_management_app/widgets/screens/home.dart';
import 'package:home_management_app/widgets/screens/profile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: 'Propiedades',
          backgroundColor: Color(0xff071d40),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Perfil',
          backgroundColor: Colors.green,
        ),
      ],
      selectedItemColor: Colors.amber[800],
    );
  }
}
