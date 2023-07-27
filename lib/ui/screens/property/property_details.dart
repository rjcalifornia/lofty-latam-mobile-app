// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:home_management_app/ui/screens/lease/create_lease.dart';
import 'package:home_management_app/ui/screens/property/edit_property.dart';
import 'package:home_management_app/ui/widgets/home_leases_container.dart';
import 'package:home_management_app/ui/widgets/home_services_container.dart';
import 'package:image_picker/image_picker.dart';
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
  String? accessToken;
  File? image;
  dynamic selectedItem;

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

  void setToken() async {
    setState(() {
      accessToken = widget.accessToken.toString();
    });
  }

  Future pickImage(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final selectedImage = File(image.path);

      final response = await FlutterImageCompress.compressWithFile(
        selectedImage.absolute.path,
        minWidth: 720,
        minHeight: 480,
        quality: 50.truncate(),
      );

      String base64Image = base64Encode(response!);

      _propertiesBloc.storePropertyPicture(
          base64Image, propertyDetails!.id, context);
      await _getProperty();
      setState(() {
        getDetails = _getProperty();
      });
    } on PlatformException catch (e) {
      //print('Failed to pick image: $e');
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar"))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails = _getProperty();
    setToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateLeaseScreen(
                        property: propertyDetails,
                      ))).then((value) => _getProperty());
        },
        backgroundColor: BrandColors.rausch,
        child: const Icon(Icons.add_outlined),
      ),
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
                                  child: const Row(children: []),
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
                                    child: CachedNetworkImage(
                                      imageUrl: propertyDetails!
                                          .propertyPictures!.imageLinkName
                                          .toString(),
                                      httpHeaders: {
                                        'Authorization': 'Bearer $accessToken'
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: const Alignment(0.8, 0.72),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: BrandColors.rausch,
                                      boxShadow: [
                                        BoxShadow(
                                            color: BrandColors.foggy,
                                            blurRadius: 2.2,
                                            offset: Offset(0, 1)),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(3.0),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.image_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        pickImage(context);
                                      },
                                    ),
                                  )),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const AppPage()),
                                        // );
                                      },
                                    ),
                                    const Spacer(),
                                    PopupMenuButton(
                                      color: Colors.white,
                                      onSelected: (value) {},
                                      itemBuilder: (BuildContext ctx) {
                                        return [
                                          PopupMenuItem(
                                            //Yeah this is the only way
                                            //to navigate without a named route:
                                            //https://github.com/flutter/flutter/issues/87766
                                            onTap: () => WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return EditPropertyScreen(
                                                      property: propertyDetails,
                                                    );
                                                  },
                                                ),
                                              ).then((value) => _getProperty());
                                            }),
                                            child: const Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit_outlined,
                                                      color: BrandColors.hof,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      "Editar",
                                                      style: TextStyle(
                                                          color:
                                                              BrandColors.hof),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Column(children: [
                                              Row(children: [
                                                Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: BrandColors.hof,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Eliminar",
                                                  style: TextStyle(
                                                      color: BrandColors.hof),
                                                )
                                              ])
                                            ]),
                                          )
                                        ];
                                      },
                                    ),
                                    /*
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),*/
                                  ],
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
                                                color: BrandColors.hof,
                                                fontSize: 16),
                                      ),
                                      Text("Cuartos",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: BrandColors.hof,
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
                                                  color: BrandColors.hof,
                                                  fontSize: 16)),
                                      Text("Camas",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: BrandColors.hof,
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
                                                  color: BrandColors.hof,
                                                  fontSize: 16)),
                                      Text("Baños",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: BrandColors.hof,
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
                                          Icons.location_on_outlined,
                                          color: BrandColors.foggy,
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Add some spacing between the icon and text

                                        Expanded(
                                          child: Text(
                                            propertyDetails!.address.toString(),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Contratos",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: BrandColors.loft,
                                        fontWeight: FontWeight.bold),
                              ),
                              propertyDetails!.leases!.isEmpty
                                  ? const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text(
                                            "No se encontraron contratos de alquiler",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: BrandColors.foggy),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : HomeLeasesContainer(
                                      propertyDetails: propertyDetails),
                            ],
                          ),
                        ),
                      ],
                    ));
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
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
    );
  }
}
