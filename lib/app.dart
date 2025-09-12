import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/modules/home/screens/home.dart';
import 'package:home_management_app/modules/home/screens/notifications.dart';
import 'package:home_management_app/modules/profile/screens/profile.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: _screens.elementAt(_currentIndex),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, -3), // negative Y → shadow on top
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0, // disable internal elevation
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12, // keep font size same
              unselectedFontSize: 12, // same as selected
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/home.png',
                    width: 22,
                    height: 22,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/home_active.png',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/notification.png',
                    width: 22,
                    height: 22,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/notification_active.png',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Notificaciones',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/profile.png',
                    width: 22,
                    height: 22,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/profile_active.png',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Mi perfil',
                ),
              ],
              selectedItemColor: BrandColors.loft,
              unselectedItemColor: BrandColors.loft,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
            ),
          )),
    );
  }
}
