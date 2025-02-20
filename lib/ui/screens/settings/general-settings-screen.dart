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
                                resendValidationEmailDialogBuilder(context);
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
                                  "Eliminará todos sus datos personales, propiedades creadas, y registros de cobros",
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
                          deactivateAccountDialogBuilder(context);
                        }),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.waveDots(
                    color: BrandColors.fty, size: 28),
              );
            }
          })),
    );
  }

  Future<void> resendValidationEmailDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reenviar correo de validación'),
          surfaceTintColor: Colors.white,
          content: const SingleChildScrollView(
            child: SizedBox(
              //height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("¿Desea reenviar el correo de validación de cuenta?")
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Reenviar correo',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                //  Navigator.of(context).pop();
                userBloc.resendVerificationEmail(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deactivateAccountDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar cuenta'),
          surfaceTintColor: Colors.white,
          content: const SingleChildScrollView(
            child: SizedBox(
              //height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "¿Está seguro que desea eliminar su cuenta? Esta acción no se puede revertir.")
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sí, eliminar mi cuenta',
                  style: TextStyle(color: Colors.red)),
              onPressed: () {
                //  Navigator.of(context).pop();
                userBloc.deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }
}
