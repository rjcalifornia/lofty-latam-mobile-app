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
      print(user);
      loader = true;
    });
    return loader;
  }

  @override
  void initState() {
    // TODO: implement initState
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
                child: Column(children: [
                  ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [Text(snapshot.data.toString())],
                          ),
                          Row(
                            children: [
                              Text(
                                'Nombre',
                                style: TextStyle(color: BrandColors.foggy),
                              )
                            ],
                          )
                        ],
                      ),
                      trailing: const Text("Editar"),
                      onTap: () {}
                      /*
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInformationScreen())),*/
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
}
