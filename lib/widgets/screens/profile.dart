import 'package:flutter/material.dart';
import 'package:home_management_app/widgets/utils/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xfff5f6f5),
        appBar: AppBar(
          backgroundColor: const Color(0xfff5f6f5),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: GestureDetector());
  }
}
