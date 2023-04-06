import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/login_bloc.dart';
import 'package:home_management_app/widgets/utils/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? firstName;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      firstName = prefs.getString("first_name");
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f5),
      appBar: AppBar(
        backgroundColor: const Color(0xfff5f6f5),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hola,",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .apply(color: Colors.grey[500]),
                ),
                Text(
                  firstName.toString(),
                  style: Theme.of(context).textTheme.headline4!.apply(
                      color: const Color(0xff071d40), fontWeightDelta: 2),
                ),
              ],
            ),
          )),
    );
  }
}
