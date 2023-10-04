// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/login_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/screens/settings/general-settings-screen.dart';
import 'package:home_management_app/ui/screens/user/change_password.dart';
import 'package:home_management_app/ui/screens/user/personal_information.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //final PropertiesBloc _propertiesBloc = PropertiesBloc();
  final LoginBloc _loginBloc = LoginBloc();
  String? firstName;
  late String fullName;
  late String rolType;

  @override
  void initState() {
    super.initState();
    fullName = UserPreferences.getFullName() ?? "Falló obtener FullName";
    rolType = UserPreferences.getRolType() ?? "Falló obtener RolType";
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30, bottom: 18, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Perfil",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.black, fontWeightDelta: 1),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/img/generic_avatar.png'),
                radius: 36,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.black, fontWeightDelta: 1)),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    rolType,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: BrandColors.hof),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Text(
            "Configuración",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Información personal'),
                    trailing: Icon(Icons.chevron_right_outlined),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalInformationScreen())),
                  ),
                  ListTile(
                    leading: Icon(Icons.password),
                    title: Text('Cambiar contraseña'),
                    trailing: Icon(Icons.chevron_right_outlined),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen())),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Preferencias'),
                    trailing: Icon(Icons.chevron_right_outlined),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeneralSettingsScreen(),
                        )),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Cerrar Sesion'),
                    trailing: Icon(Icons.chevron_right_outlined),
                    onTap: () {
                      logoutDialogBuilder(context);
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<void> logoutDialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Atención'),
              content: SizedBox(
                height: 70,
                child: Center(
                  child: Text('¿Está seguro que quiere salir?'),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cerrar sesión'),
                  onPressed: () {
                    _loginBloc.logout(context);
                    // Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}
