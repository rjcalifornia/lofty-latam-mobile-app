import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
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
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff071d40),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Propiedades disponibles",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          countProperties.toString(),
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 11.0),
                                  primary: const Color(0xff071d40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Registrar nueva propiedad',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      listProperties?.isEmpty == false
                          ? Container(
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
