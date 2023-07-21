// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/User.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({
    super.key,
  });
  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final UserBloc userBloc = UserBloc();
  User? user;
  bool loader = false;
  Future? personalInfo;

  Future<bool> getPersonalInfo() async {
    final personalInfo = await userBloc.getUserInformation();
    setState(() {
      user = personalInfo;
      loader = true;
    });
    return loader;
  }

  @override
  void initState() {
    super.initState();
    personalInfo = getPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(
          future: personalInfo,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Información personal",
                        style: TextStyle(
                            color: BrandColors.loft,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [Text("Nombre")],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${user!.name} ${user!.lastname}",
                                    style: const TextStyle(
                                        color: BrandColors.foggy),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: const Text(
                            "Edita",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: BrandColors.hof,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          onTap: () {
                            _dialogBuilder(context);
                          }
                          /*
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen())),*/
                          ),
                      const Divider(
                        thickness: 1,
                      ),
                      ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [Text("Número telefónico")],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${user!.phone}",
                                    style: const TextStyle(
                                        color: BrandColors.foggy),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: const Text(
                            "Edita",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: BrandColors.hof,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          onTap: () {}
                          /*
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen())),*/
                          ),
                      const Divider(
                        thickness: 1,
                      ),
                      ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [Text("Correo electrónico")],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${user!.email}",
                                    style: const TextStyle(
                                        color: BrandColors.foggy),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: const Text(
                            "Edita",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: BrandColors.hof,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          onTap: () {}
                          /*
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen())),*/
                          ),
                      const Divider(
                        thickness: 1,
                      ),
                      ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [Text("DUI")],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${user!.dui}",
                                    style: const TextStyle(
                                        color: BrandColors.foggy),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: const Text(
                            "Edita",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: BrandColors.hof,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          onTap: () {}
                          /*
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen())),*/
                          ),
                      const Divider(
                        thickness: 1,
                      ),
                    ]),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffff385c), size: 28),
              );
            }
          })),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Actualiza tu nombre'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(children: [
                  Icon(
                    Icons.person_2_outlined,
                    color: BrandColors.hof,
                    size: 14,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Nombres",
                    style: TextStyle(color: BrandColors.hof),
                  ),
                ]),
                TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff6f6f6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        hintText: 'Nombres')),
                const SizedBox(
                  height: 22,
                ),
                const Row(children: [
                  Icon(
                    Icons.person_2_outlined,
                    color: BrandColors.hof,
                    size: 14,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Apellidos",
                    style: TextStyle(color: BrandColors.hof),
                  ),
                ]),
                TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff6f6f6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        hintText: 'Apellidos')),
              ],
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
              child: const Text('Actualizar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
