import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/ui/widgets/home_options_container.dart';
import 'package:home_management_app/ui/widgets/properties_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();
  List? listProperties;
  bool loader = false;
  Future? getProperties;
  int? countProperties;
  late String accessToken;
  late String displayName;

  Future<bool> _getPropertiesList() async {
    final propertiesList = await _propertiesBloc.getPropertiesList();

    setState(() {
      listProperties = propertiesList;
      countProperties = listProperties?.length;
      loader = true;
    });
    return loader;
  }

  @override
  void initState() {
    super.initState();
    displayName =
        UserPreferences.getDisplayName() ?? "Falló obtener DisplayName";

    accessToken =
        UserPreferences.getAccessToken() ?? "Falló obtener AccessToken";

    getProperties = _getPropertiesList();
  }

  @override
  Widget build(BuildContext context) {
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
                "Hola,",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.grey),
              ),
              Text(
                displayName.toString(),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: const Color(0xff071d40),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 26.0,
              ),
              HomeOptionsContainer(
                countProperties: countProperties.toString(),
                getProperties: getProperties,
              ),
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

              FutureBuilder(
                  future: getProperties,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          listProperties?.isEmpty == false
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      itemCount: listProperties?.length,
                                      itemBuilder: (ctx, i) {
                                        return PropertiesContainer(
                                          id: i,
                                          property: listProperties,
                                          token: accessToken,
                                        );
                                      }),
                                )
                              : const Text('No se encontraron datos'),
                        ],
                      );
                    } else {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color(0xffff385c), size: 28),
                      );
                    }
                  })),
              //another
            ],
          ),
          //here
        ));
  }
}
