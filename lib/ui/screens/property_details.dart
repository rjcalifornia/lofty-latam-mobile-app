// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';
import 'package:home_management_app/ui/widgets/home_services_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final id;
  final accessToken;
  const PropertyDetailsScreen(
      {super.key, required this.id, required this.accessToken});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();
  bool loader = false;
  Future? getDetails;

  Property? propertyDetails;
  Future<bool> _getProperty() async {
    final getPropertyDetails =
        await _propertiesBloc.getPropertyDetails(widget.id);
    setState(() {
      loader = true;

      propertyDetails = getPropertyDetails;
    });
    return loader;
  }

  @override
  void initState() {
    super.initState();
    getDetails = _getProperty();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: FutureBuilder(
                  future: getDetails,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  bottom: 150,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    color: const Color(0xffFF5A5F),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      const Spacer(),
                                    ]),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 15,
                                  child: Container(
                                    margin: const EdgeInsets.all(25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.network(
                                        propertyDetails!
                                            .propertyPictures!.imageLinkName
                                            .toString(),
                                        headers: {
                                          'Authorization':
                                              'Bearer $widget.accessToken'
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 18, left: 22, right: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Expanded(
                                      child: Text(
                                    propertyDetails!.name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: BrandColors.rausch,
                                            fontWeight: FontWeight.bold),
                                  )),
                                ]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          "${propertyDetails!.bedrooms}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: BrandColors.loft,
                                                  fontSize: 16),
                                        ),
                                        Text("Cuartos",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: BrandColors.loft,
                                                    fontSize: 16)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("${propertyDetails!.beds}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: BrandColors.loft,
                                                    fontSize: 16)),
                                        Text("Camas",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: BrandColors.loft,
                                                    fontSize: 16)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("${propertyDetails!.bathrooms}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: BrandColors.loft,
                                                    fontSize: 16)),
                                        Text("Baños",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: BrandColors.loft,
                                                    fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.map,
                                            color: BrandColors.foggy,
                                          ),
                                          const SizedBox(
                                              width:
                                                  8), // Add some spacing between the icon and text

                                          Expanded(
                                            child: Text(
                                              propertyDetails!.address
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .apply(
                                                      color: BrandColors.foggy),
                                              softWrap:
                                                  true, // Allow the text to wrap to the next line
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                HomeServicesContainer(
                                  propertyDetails: propertyDetails,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                    } else {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color(0xffff385c), size: 28),
                      );
                    }
                  }),
                ),
              ),

              //ending
            ],
          ),
        ),
      ),
    );
  }
}
