// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_management_app/Http/Controllers/LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginController>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                        color: Color.fromARGB(255, 80, 85, 89),
                        fontSize: 25.0,
                        fontWeight: FontWeight.normal),
                  ),
                  Container(
                    width: width < 800
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.65,
                    padding:
                        EdgeInsets.symmetric(vertical: 35.0, horizontal: 35.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        StreamBuilder(
                          stream: bloc.usernameError,
                          builder: (ctx, AsyncSnapshot<String> usernameError) {
                            return TextField(
                              decoration: InputDecoration(
                                labelText: 'Escriba su nombre de usuario',
                                errorText: usernameError.hasError
                                    ? usernameError.toString()
                                    : null,
                              ),
                              onChanged: bloc.usernameChanged,
                            );
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        StreamBuilder(
                            stream: bloc.passwordError,
                            builder:
                                (ctx, AsyncSnapshot<String> passwordError) {
                              return TextField(
                                decoration: InputDecoration(
                                  labelText: 'Escriba su contraseña',
                                  errorText: passwordError.hasError
                                      ? passwordError.toString()
                                      : null,
                                ),
                                onChanged: bloc.passwordChanged,
                                obscureText: true,
                              );
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder(
                          stream: bloc.submitCheck,
                          builder: (ctx, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                child: Column(
                                  children: [
                                    Text("Complete los datos para ingresar")
                                  ],
                                ),
                              );
                            } else {
                              return ElevatedButton(
                                  onPressed: () {
                                    bloc.submit(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff6633CC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text("Ingresar"));
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
