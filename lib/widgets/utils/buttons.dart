// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomAuthButtons extends StatelessWidget {
  final Color buttonColor;
  final Border border;
  final String buttonText;
  final String route;
  const CustomAuthButtons(
      {super.key,
      required this.buttonColor,
      required this.border,
      required this.buttonText,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: buttonColor,
          border: border,
        ),
        padding: EdgeInsets.symmetric(vertical: 9.0),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontFamily: 'Roboto'),
        )),
      ),
    );
  }
}
