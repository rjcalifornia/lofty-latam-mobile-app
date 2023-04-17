// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();

  String? firstName;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 30, bottom: 18, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perfil",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .apply(color: const Color(0xff000000), fontWeightDelta: 1),
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
            FutureBuilder(
              future: _propertiesBloc.getUserDetails(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data as Map<String, dynamic>;
                  var fullName = "${data['firstName']} ${data['lastName']}";
                  var rolName = "${data['rolName']}";

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .apply(
                                      color: const Color(0xff000000),
                                      fontWeightDelta: 1)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            rolName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(color: Colors.grey[700]),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return SizedBox(
                    height: 28,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xffff385c), size: 22),
                  );
                }
              },
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              "Configuración",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 18,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Perfil'),
                      trailing: Icon(Icons.chevron_right_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.password),
                      title: Text('Cambiar contraseña'),
                      trailing: Icon(Icons.chevron_right_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Preferencias'),
                      trailing: Icon(Icons.chevron_right_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Cerrar Sesion'),
                      trailing: Icon(Icons.chevron_right_outlined),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
