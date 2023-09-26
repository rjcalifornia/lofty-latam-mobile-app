import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/User.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  final UserBloc userBloc = UserBloc();
  User? user;
  bool loader = false;
  Future? personalInfo;
  Future<bool> getPersonalInfo() async {
    final personalInfo = await userBloc.getUserInformation();
    setState(() {
      user = personalInfo;
      loader = true;

      userBloc.changeName(user!.name.toString());
      userBloc.changeLastname(user!.lastname.toString());
      userBloc.changePhone(user!.phone.toString());
      userBloc.changeEmail(user!.email.toString());
    });
    return loader;
  }

  @override
  void initState() {
    super.initState();
    personalInfo = getPersonalInfo();
  }

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
                      "Configuración",
                      style: TextStyle(
                          color: BrandColors.loft,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    if (user?.isEmailVerified != true)
                      Column(
                        children: [
                          ListTile(
                              title: const Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Reenviar correo de validación")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Valide su cuenta para aprovechar al máximo su cuenta de Lofty",
                                        style:
                                            TextStyle(color: BrandColors.foggy),
                                      ))
                                    ],
                                  )
                                ],
                              ),
                              trailing: const Icon(
                                Icons.email_outlined,
                                color: BrandColors.foggy,
                              ),
                              onTap: () {
                                //fullNameDialogBuilder(context);
                              }),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ListTile(
                        title: const Column(
                          children: [
                            Row(
                              children: [Text("Desactivar cuenta")],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Eliminará todos sus datos personales y registros de cobros",
                                  style: TextStyle(color: BrandColors.foggy),
                                ))
                              ],
                            )
                          ],
                        ),
                        trailing: const Icon(
                          Icons.warning_outlined,
                          color: BrandColors.arches,
                        ),
                        onTap: () {
                          //fullNameDialogBuilder(context);
                        }),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: BrandColors.fty, size: 28),
              );
            }
          })),
    );
  }
}
