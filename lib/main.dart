// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_management_app/widgets/screens/home.dart';
import 'package:provider/provider.dart';

import 'package:home_management_app/bloc/login_bloc.dart';
import 'package:home_management_app/widgets/auth/welcome.dart';
import 'package:home_management_app/widgets/screens/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc();

    return MultiProvider(
        providers: [
          Provider<LoginBloc>(
            create: (_) => LoginBloc(),
            dispose: (_, bloc) => bloc.dispose(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Roboto',
              primarySwatch: Colors.blue,
              backgroundColor: Color(0xfff5f6f5)),
          home: FutureBuilder(
            future: loginBloc.checkAccessTokenValidity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              } else if (snapshot.hasData && snapshot.data == true) {
                return const HomeScreen();
              } else {
                return const WelcomePage();
              }
            },
          ),
          routes: {'signin': (context) => LoginScreen()},
        ));
  }
}
