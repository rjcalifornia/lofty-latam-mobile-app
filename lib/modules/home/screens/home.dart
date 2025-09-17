import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/modules/property/screens/property_details.dart';
import 'package:home_management_app/modules/home/widgets/home_options_container.dart';
import 'package:home_management_app/modules/home/widgets/property_list_widget.dart';
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
    return Scaffold(
      body: SafeArea(
        // 👈 handles top/bottom notches
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20), // no bottom padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hola,",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: BrandColors.foggy),
              ),
              Text(
                displayName,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: BrandColors.loft, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22.0),
              HomeOptionsContainer(
                countProperties: countProperties.toString(),
                getProperties: getProperties,
              ),
              const SizedBox(height: 30),
              const Text(
                "Propiedades",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: BrandColors.loft,
                ),
              ),
              const SizedBox(height: 10),

              // the list fills all remaining space
              Expanded(
                child: FutureBuilder(
                  future: getProperties,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: BrandColors.fty,
                          size: 26,
                        ),
                      );
                    }
                    if (listProperties == null || listProperties!.isEmpty) {
                      return const Center(
                        child: Text('No hay propiedades registradas'),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: _getPropertiesList,
                      child: ListView.builder(
                        padding: EdgeInsets.zero, // 👈 remove default insets
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: listProperties!.length,
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            onTap: () async {
                              final value = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PropertyDetailsScreen(
                                    id: listProperties![i]['id'],
                                    accessToken: accessToken,
                                  ),
                                ),
                              );
                              if (value == true) {
                                _getPropertiesList();
                              }
                            },
                            child: PropertyListWidget(
                              id: i,
                              property: listProperties,
                              token: accessToken,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
