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
  bool _wifi = false;

  final PropertiesBloc _propertyBloc = PropertiesBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: BrandColors.rausch,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
                child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5.4,
                        width: double.infinity,
                        child: const Stack(
                          children: [
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                stream: _propertyBloc.wifiStream,
                                builder: (context, AsyncSnapshot snapshot) {
                                  return SwitchListTile(
                                    title: const Text('¿Tiene wifi?'),
                                    value: _wifi,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _wifi = value;
                                      });
                                    },
                                    secondary: const Icon(Icons.wifi_outlined),
                                  );
                                }),
                            const Divider(height: 0),
                            const SizedBox(
                              height: 6,
                            ),
                            StreamBuilder(
                                stream: _propertyBloc.airConditionerStream,
                                builder: (context, AsyncSnapshot snapshot) {
                                  return SwitchListTile(
                                    title: const Text(
                                        '¿Tiene aire acondicionado?'),
                                    value: _ac,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _ac = value;
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.ac_unit_outlined),
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
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.soup_kitchen_outlined),
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
                                    title:
                                        const Text('¿Tiene mesa de comedor?'),
                                    value: _dinningTable,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _dinningTable = value;
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
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.kitchen_outlined),
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
                                    title:
                                        const Text('¿Tiene muebles de sala?'),
                                    value: _furniture,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _furniture = value;
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.weekend_outlined),
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
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.garage_outlined),
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
                                    child: const Column(
                                      children: [
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
                                      _propertyBloc.changeWifi(
                                          (_wifi == true ? 1 : 0).toString());
                                      _propertyBloc.changeDinning(
                                          (_dinningTable == true ? 1 : 0)
                                              .toString());
                                      _propertyBloc.changeAirConditioner(
                                          (_ac == true ? 1 : 0).toString());
                                      _propertyBloc.changeKitchen(
                                          (_kitchen == true ? 1 : 0)
                                              .toString());
                                      _propertyBloc.changeDishSink(
                                          (_sink == true ? 1 : 0).toString());
                                      _propertyBloc.changeFridge(
                                          (_fridge == true ? 1 : 0).toString());
                                      _propertyBloc.changeTv(
                                          (_tv == true ? 1 : 0).toString());
                                      _propertyBloc.changeFurniture(
                                          (_furniture == true ? 1 : 0)
                                              .toString());
                                      _propertyBloc.changeGarage(
                                          (_garage == true ? 1 : 0).toString());

                                      _propertyBloc.createProperty(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: BrandColors.fty,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
              ],
            ))));
  }
}
