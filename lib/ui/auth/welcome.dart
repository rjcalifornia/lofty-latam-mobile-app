// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/utils/buttons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0,
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                "assets/img/main.jpg",
                fit: BoxFit.fitHeight,
              )),
          Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
                Image.asset(
                  "assets/img/home.png",
                  height: 120,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Lofty",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 31,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Simplificando pagos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
                Spacer(),
                CustomAuthButtons(
                    buttonColor: BrandColors.arches,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    buttonText: "Registrarse",
                    route: "signup"),
                SizedBox(
                  height: 11,
                ),
                CustomAuthButtons(
                    buttonColor: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    buttonText: "Ingresar",
                    route: "signin"),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
