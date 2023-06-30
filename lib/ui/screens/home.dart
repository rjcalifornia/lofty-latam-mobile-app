import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 25, bottom: 18, left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Hola,",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: BrandColors.foggy),
        ),
        Text(
          displayName.toString(),
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: BrandColors.loft, fontWeight: FontWeight.bold),
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
              .headlineSmall!
              .apply(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),

        FutureBuilder(
            future: getProperties,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    listProperties?.isEmpty == false
                        ? RefreshIndicator(
                            onRefresh: () {
                              return _getPropertiesList();
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: listProperties?.length,
                                  itemBuilder: (ctx, i) {
                                    return PropertiesContainer(
                                      id: i,
                                      property: listProperties,
                                      token: accessToken,
                                    );
                                  }),
                            ))
                        : const Text('No se encontraron datos'),
                  ],
                );
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: BrandColors.arches, size: 28),
                );
              }
            })),
        //another
      ]),
    );
    //here
  }
}
