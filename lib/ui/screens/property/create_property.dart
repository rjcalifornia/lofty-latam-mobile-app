import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/widgets/create_property_fancy_header.dart';

class CreatePropertyScreen extends StatefulWidget {
  const CreatePropertyScreen({super.key});

  @override
  State<CreatePropertyScreen> createState() => _CreatePropertyScreenState();
}

class _CreatePropertyScreenState extends State<CreatePropertyScreen> {
  bool _ac = false;
  bool _kitchen = false;
  bool _dinningTable = false;
  bool _sink = false;
  bool _fridge = false;
  bool _tv = false;
  bool _furniture = false;
  bool _garage = false;
  final PropertiesBloc _propertyBloc = PropertiesBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
            child: Scaffold(
                body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5.4,
                      width: double.infinity,
                      child: Stack(
                        children: const [
                          Positioned.fill(child: CreatePropertyFancyHeader())
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Información general",
                            style: TextStyle(
                                color: BrandColors.foggy,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Nombre",
                            style: TextStyle(color: BrandColors.loft),
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.nameStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return TextField(
                                    keyboardType: TextInputType.name,
                                    onChanged: _propertyBloc.changeName,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xfff6f6f6),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      hintText:
                                          "Escriba un título para la propiedad",
                                    ));
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Dirección",
                            style: TextStyle(color: BrandColors.loft),
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.addressStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return TextField(
                                    keyboardType: TextInputType.name,
                                    onChanged: _propertyBloc.changeAddress,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xfff6f6f6),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      hintText: "Dirección de la propiedad",
                                    ));
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Habitaciones",
                            style: TextStyle(color: BrandColors.loft),
                          ),
                          StreamBuilder(
                            stream: _propertyBloc.bedroomsStream,
                            builder: (context, AsyncSnapshot snapshot) {
                              return TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                onChanged: _propertyBloc.changeBedrooms,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xfff6f6f6),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    hintText: "Ejemplo: 2",
                                    //labelText: 'Escriba la cantidad recibida',
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Camas",
                            style: TextStyle(color: BrandColors.loft),
                          ),
                          StreamBuilder(
                            stream: _propertyBloc.bedsStream,
                            builder: (context, AsyncSnapshot snapshot) {
                              return TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                onChanged: _propertyBloc.changeBeds,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xfff6f6f6),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    hintText: "Ejemplo: 2",
                                    //labelText: 'Escriba la cantidad recibida',
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Baños",
                            style: TextStyle(color: BrandColors.loft),
                          ),
                          StreamBuilder(
                            stream: _propertyBloc.bathroomsStream,
                            builder: (context, AsyncSnapshot snapshot) {
                              return TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                onChanged: _propertyBloc.changeBathrooms,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xfff6f6f6),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    hintText: "Ejemplo: 1",
                                    //labelText: 'Escriba la cantidad recibida',
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Amenidades",
                            style: TextStyle(
                                color: BrandColors.foggy,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.airConditionerStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title:
                                      const Text('¿Tiene aire acondicionado?'),
                                  value: _ac,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _ac = value;
                                      _propertyBloc.changeAirConditioner(
                                          (_ac == true ? 1 : 0).toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.ac_unit_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.kitchenStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene cocina?'),
                                  value: _kitchen,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _kitchen = value;
                                      _propertyBloc.changeKitchen(
                                          (_kitchen == true ? 1 : 0)
                                              .toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.kitchen_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.dinningStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene mesa de comedor?'),
                                  value: _dinningTable,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _dinningTable = value;
                                      _propertyBloc.changeDinning(
                                          (_dinningTable == true ? 1 : 0)
                                              .toString());
                                    });
                                  },
                                  secondary:
                                      const Icon(Icons.table_bar_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.dishSinkStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene lavatrastos?'),
                                  value: _sink,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _sink = value;
                                      _propertyBloc.changeDishSink(
                                          (_sink == true ? 1 : 0).toString());
                                    });
                                  },
                                  secondary:
                                      const Icon(Icons.countertops_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.fridgeStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene refrigeradora?'),
                                  value: _fridge,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _fridge = value;
                                      _propertyBloc.changeFridge(
                                          (_fridge == true ? 1 : 0).toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.kitchen_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.tvStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene televisión?'),
                                  value: _tv,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _tv = value;
                                      _propertyBloc.changeTv(
                                          (_tv == true ? 1 : 0).toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.tv_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.furnitureStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene muebles de sala?'),
                                  value: _furniture,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _furniture = value;
                                      _propertyBloc.changeFurniture(
                                          (_furniture == true ? 1 : 0)
                                              .toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.weekend_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 6,
                          ),
                          StreamBuilder(
                              stream: _propertyBloc.garageStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                return SwitchListTile(
                                  title: const Text('¿Tiene cochera?'),
                                  value: _garage,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _garage = value;
                                      _propertyBloc.changeGarage(
                                          (_garage == true ? 1 : 0).toString());
                                    });
                                  },
                                  secondary: const Icon(Icons.garage_outlined),
                                );
                              }),
                          const Divider(height: 0),
                          const SizedBox(
                            height: 16,
                          ),
                          StreamBuilder(
                            stream: _propertyBloc.verifyPropertyData,
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                // ignore: avoid_unnecessary_containers
                                return Container(
                                  child: Column(
                                    children: const [
                                      Center(
                                        child: Text(
                                          "Complete todos los datos requeridos",
                                          style: TextStyle(
                                              color: BrandColors.foggy),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    // _propertyBloc.generateReceipt(
                                    //     context, widget.lease.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: BrandColors.arches,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.beenhere_outlined, size: 28),
                                      SizedBox(width: 8),
                                      Text("Almacenar datos",
                                          style: TextStyle(fontSize: 22)),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Crear una nueva propiedad",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))));
  }
}
