// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/core/widgets/success_message_widget.dart';
import 'package:home_management_app/modules/property/models/Property.dart';
import 'package:home_management_app/modules/lease/screens/create_lease.dart';
import 'package:home_management_app/modules/lease/screens/lease_details.dart';
import 'package:home_management_app/modules/property/screens/edit_property.dart';
import 'package:home_management_app/modules/property/widgets/home_leases_container.dart';
import 'package:home_management_app/modules/property/widgets/home_services_container.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';

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
              surfaceTintColor: Colors.white,
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails = _getProperty();
    //print(getDetails);
    setToken();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double screenPercentage = 0.35;
    if (width > 800) {
      screenPercentage = 0.65;
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * screenPercentage;

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
        backgroundColor: BrandColors.fty,
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
      body: Stack(
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
                        height: imageHeight,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              left: 0,
                              right: 0,
                              top: 0,
                              child: Container(
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: propertyDetails!
                                      .propertyPictures!.imageLinkName
                                      .toString(),
                                  httpHeaders: {
                                    'Authorization': 'Bearer $accessToken'
                                  },
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 16,
                                right: 16,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: BrandColors.fty,
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
                              top: 44,
                              left: 14,
                              right: 14,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.chevron_left,
                                        color: BrandColors.fty,
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
                                  ),
                                  const Spacer(),
                                  Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: PopupMenuButton(
                                        surfaceTintColor: Colors.white,
                                        icon: const Icon(
                                          Icons.more_vert_outlined,
                                          color: BrandColors.fty,
                                        ),
                                        onSelected: (value) {},
                                        itemBuilder: (BuildContext ctx) {
                                          return [
                                            PopupMenuItem(
                                              //Yeah this is the only way
                                              //to navigate without a named route:
                                              //https://github.com/flutter/flutter/issues/87766
                                              onTap: () => WidgetsBinding
                                                  .instance
                                                  .addPostFrameCallback((_) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return EditPropertyScreen(
                                                        property:
                                                            propertyDetails,
                                                      );
                                                    },
                                                  ),
                                                ).then(
                                                    (value) => _getProperty());
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
                                                            color: BrandColors
                                                                .hof),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                //Yeah this is the only way
                                                //to safely open a dialog
                                                //https://github.com/flutter/flutter/issues/87766
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  removePropertyDialogBuilder(
                                                      context);
                                                });
                                              },
                                              value: 'delete',
                                              child: const Column(children: [
                                                Row(children: [
                                                  Icon(
                                                    Icons
                                                        .delete_forever_outlined,
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
                                      )),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BrandColors.rausch,
                                    fontSize: 20),
                              )),
                            ]),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons/bedrooms.png',
                                        width: 50,
                                      ),
                                      Text(
                                          "${propertyDetails!.bedrooms} cuartos",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: BrandColors.loft,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/icons/bed.png',
                                          width: 50,
                                        ),
                                        Text("${propertyDetails!.beds} camas",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: BrandColors.loft,
                                                fontSize: 12)),
                                      ],
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/icons/bathroom.png',
                                          width: 50,
                                        ),
                                        Text(
                                            "${propertyDetails!.bathrooms} baño",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: BrandColors.loft,
                                                fontSize: 12)),
                                      ],
                                    )),
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
                                              .apply(color: BrandColors.foggy),
                                          softWrap:
                                              true, // Allow the text to wrap to the next line
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        Icons.location_city_outlined,
                                        color: BrandColors.foggy,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Add some spacing between the icon and text

                                      Expanded(
                                        child: Text(
                                          'Distrito de ${propertyDetails!.location!.distritoId!.nombre}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .apply(color: BrandColors.foggy),
                                          softWrap:
                                              true, // Allow the text to wrap to the next line
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        Icons.location_pin,
                                        color: BrandColors.foggy,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Add some spacing between the icon and text

                                      Expanded(
                                        child: Text(
                                          '${propertyDetails!.location!.distritoId!.municipioId!.nombre}, ${propertyDetails!.location!.distritoId!.municipioId!.departamentoId!.nombre}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .apply(color: BrandColors.foggy),
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
                                : Container(
                                    height: 170,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            propertyDetails!.leases!.length,
                                        itemBuilder: (ctx, i) {
                                          return GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LeaseDetailsScreen(
                                                            leaseId:
                                                                propertyDetails!
                                                                    .leases![i]
                                                                    .id,
                                                          ))).then((value) => {
                                                    {_getProperty()}
                                                  }),
                                              child: HomeLeasesContainer(
                                                  propertyDetails:
                                                      propertyDetails,
                                                  iterator: i));
                                        })),
                          ],
                        ),
                      ),
                    ],
                  ));
                } else {
                  return CustomDialogs.navigationLoader("Espere por favor...");
                }
              }),
            ),
          ),

          //ending
        ],
      ),
    );
  }

  Future<void> waitingDialogBuilder(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const FullscreenLottieDialog(
          asset: 'assets/animations/success.json',
          content: 'Contrato ha sido guardado correctamente.',
        );
      },
    );
  }

  Future<void> removePropertyDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar propiedad'),
          surfaceTintColor: Colors.white,
          content: const SingleChildScrollView(
            child: SizedBox(
              //height: MediaQuery.of(context).size.height / 6.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text('¿Está seguro que desea eliminar la propiedad?'),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: [
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                        size: 14,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Acción es irreversible",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                //  getPersonalInfo();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child:
                  const Text('Continuar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _propertiesBloc.removeProperty(propertyDetails!.id, context);
              },
            ),
          ],
        );
      },
    );
  }
}
