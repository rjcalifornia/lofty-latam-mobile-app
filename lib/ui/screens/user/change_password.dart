import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final UserBloc userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 30, bottom: 18, left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  "Cambiar clave",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  "Clave anterior",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                    stream: userBloc.oldPasswordStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      return TextField(
                        obscureText: true,
                        onChanged: userBloc.changeOldPassword,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: BrandColors.hof)),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  "Nueva clave",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                    stream: userBloc.passwordStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      return TextField(
                        obscureText: true,
                        onChanged: userBloc.changePassword,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: BrandColors.hof)),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  "Vuelva a escribir la nueva clave",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                    stream: userBloc.repeatPasswordStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      return TextField(
                        obscureText: true,
                        onChanged: userBloc.changeRepeatPassword,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: BrandColors.hof)),
                        ),
                      );
                    }),
                StreamBuilder(
                  stream: userBloc.verifyPasswordsEqual,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      // ignore: avoid_unnecessary_containers
                      return Container(
                        child: const Column(
                          children: [
                            Text(
                              "Revise los datos ingresados",
                              style: TextStyle(color: BrandColors.hof),
                            )
                          ],
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          userBloc.generateReceipt(context, widget.lease.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColors.arches,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Actualizar clave",
                                style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
