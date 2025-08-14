// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_management_app/bloc/payments_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/modules/home/screens/app.dart';
import 'package:home_management_app/modules/authentication/screens/register.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:home_management_app/bloc/login_bloc.dart';
import 'package:home_management_app/modules/authentication/screens/welcome.dart';
import 'package:home_management_app/modules/authentication/screens/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

//Holy shit, updated this flutter appp however I'm being affected by this issue:
//https://github.com/flutter/flutter/issues/161119
//Issue persists
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
        Provider<PaymentsBloc>(
          create: (_) => PaymentsBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Lofty',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),

          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          //    .copyWith(background: Colors.white),
        ),
        home: FutureBuilder(
          future: loginBloc.checkAccessTokenValidity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: BrandColors.fty, size: 26),
                ),
              );
            } else if (snapshot.hasData && snapshot.data == true) {
              return const AppPage();
            } else {
              return const WelcomePage();
            }
          },
        ),
        routes: {
          'signin': (context) => LoginScreen(),
          'signup': (context) => RegistrationScreen(),
          'home': (context) => AppPage(),
          'welcome': (context) => WelcomePage(),
        },
      ),
    );
  }
}
