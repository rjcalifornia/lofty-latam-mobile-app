import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/ui/widgets/home_options_container.dart';
import 'package:home_management_app/ui/widgets/properties_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();
  String firstName = '';
  List? listProperties;
  bool loader = false;
  Future? getProperties;
  int? countProperties;

  Future<bool> _getPropertiesList() async {
    final propertiesList = await _propertiesBloc.getPropertiesList();

    setState(() {
      listProperties = propertiesList;
      countProperties = listProperties?.length;
      loader = true;
    });
    return loader;
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      firstName = prefs.getString("first_name").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    getProperties = _getPropertiesList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder(
        future: getProperties,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 18, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola,",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(color: Colors.grey[500]),
                  ),
                  Text(
                    firstName.toString(),
                    style: Theme.of(context).textTheme.headline5!.apply(
                        color: const Color(0xff071d40), fontWeightDelta: 2),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  HomeOptionsContainer(
                      countProperties: countProperties.toString()),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Propiedades",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .apply(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      listProperties?.isEmpty == false
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 1,
                              child: ListView.builder(
                                  itemCount: listProperties?.length,
                                  itemBuilder: (ctx, i) {
                                    return PropertiesContainer(
                                        id: i, property: listProperties);
                                  }),
                            )
                          : const Text('No se encontraron datos'),
                    ],
                  )
                  //another
                ],
              ),
              //here
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
