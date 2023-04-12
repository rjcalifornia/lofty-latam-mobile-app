// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_management_app/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.black,
            onPressed: () => Navigator.pop(context)),
      ),
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
                  Container(
                    height: MediaQuery.of(context).size.height / 5.6,
                    width: MediaQuery.of(context).size.width / 1,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Flexible(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                child: Image.asset(
                                  "assets/img/lofty.png",
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Lofty",
                    style: TextStyle(
                      color: Color(0xff313945),
                      fontWeight: FontWeight.bold,
                      fontSize: 31,
                    ),
                  ),
                  Text(
                    "Simplificando pagos",
                    style: TextStyle(
                      color: Color(0xff313945),
                      fontSize: 21,
                    ),
                  ),
                  SizedBox(
                    height: 12,
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
                              // ignore: avoid_unnecessary_containers
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
                                  primary: const Color(0xffff385c),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.login, size: 28),
                                    const SizedBox(width: 8),
                                    Text("Ingresar",
                                        style: TextStyle(fontSize: 22)),
                                  ],
                                ),
                              );
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
