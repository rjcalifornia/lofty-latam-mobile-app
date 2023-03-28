// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_management_app/resources/views/utils/buttons.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
              child: Image.network(
                "https://cdn.pixabay.com/photo/2015/07/15/11/49/housing-846056_1280.jpg",
                fit: BoxFit.fitHeight,
              )),
          Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  "PagoFácil",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 31,
                  ),
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
                    buttonColor: Color(0xff48808d),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    buttonText: "Crear una cuenta",
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
