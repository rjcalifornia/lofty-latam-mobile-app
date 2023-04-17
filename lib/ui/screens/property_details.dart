// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/models/Property.dart';
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
                bottom: 50,
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
                                    color: const Color(0xffff385c),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      const Spacer(),
                                      Text(
                                        propertyDetails!.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .apply(
                                                color: Colors.white,
                                                fontWeightDelta: 2),
                                      )
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
                          )
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
            ],
          ),
        ),
      ),
    );
  }
}
