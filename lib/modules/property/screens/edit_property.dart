import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Departamentos.dart';
import 'package:home_management_app/models/Distritos.dart';
import 'package:home_management_app/models/Municipios.dart';
import 'package:home_management_app/modules/property/models/Property.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class EditPropertyScreen extends StatefulWidget {
  final Property? property;
  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final PropertiesBloc _propertyBloc = PropertiesBloc();
  bool wifi = false;
  bool ac = false;
  bool kitchen = false;
  bool dinningTable = false;
  bool sink = false;
  bool fridge = false;
  bool tv = false;
  bool furniture = false;
  bool garage = false;

  void setValues() {
    setState(() {
      _propertyBloc.changeName(widget.property!.name.toString());

      _propertyBloc.changeAddress(widget.property!.address.toString());

      _propertyBloc.changeBedrooms(widget.property!.bedrooms.toString());

      _propertyBloc.changeBeds(widget.property!.beds.toString());

      _propertyBloc.changeBathrooms(widget.property!.bathrooms.toString());
      _propertyBloc
          .changeDistrito(widget.property!.location!.distritoId!.id.toString());
    });

    if (widget.property!.hasWifi == true) {
      setState(() {
        wifi = true;
      });
    }
    if (widget.property!.hasAc == true) {
      setState(() {
        ac = true;
      });
    }
    if (widget.property!.hasKitchen == true) {
      setState(() {
        kitchen = true;
      });
    }
    if (widget.property!.hasDinningRoom == true) {
      setState(() {
        dinningTable = true;
      });
    }
    if (widget.property!.hasSink == true) {
      setState(() {
        sink = true;
      });
    }
    if (widget.property!.hasFridge == true) {
      setState(() {
        fridge = true;
      });
    }
    if (widget.property!.hasTv == true) {
      setState(() {
        tv = true;
      });
    }
    if (widget.property!.hasFurniture == true) {
      setState(() {
        furniture = true;
      });
    }
    if (widget.property!.hasGarage == true) {
      setState(() {
        garage = true;
      });
    }
  }

  late String departamentoSelected = widget
      .property!.location!.distritoId!.municipioId!.departamentoId!.id
      .toString();
  late String municipioSelected =
      widget.property!.location!.distritoId!.municipioId!.id.toString();
  late String distritoSelected =
      widget.property!.location!.distritoId!.id.toString();

  List<Departamentos> departamentosList = [];
  List<Municipios> municipiosList = [];
  List<Distritos> distritosList = [];

  Future getDepartamentosData() async {
    final departamentosJson = await _propertyBloc.getDepartamentos();

    setState(() {
      departamentosList = departamentosJson;
    });
  }

  Future getMunicipiosData(departamentoId) async {
    final municipiosJson = await _propertyBloc.getMunicipios(departamentoId);

    setState(() {
      municipiosList = municipiosJson;
    });
  }

  Future getDistritosData(distritoId) async {
    final distritosJson = await _propertyBloc.getDistritos(distritoId);

    setState(() {
      distritosList = distritosJson;
    });
  }

  @override
  void initState() {
    setValues();
    getDepartamentosData();
    getMunicipiosData(departamentoSelected);
    getDistritosData(municipioSelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Container(
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
                        return TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: _propertyBloc.changeName,
                            initialValue: widget.property!.name!.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              hintText: "Escriba un título para la propiedad",
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
                        return TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: _propertyBloc.changeAddress,
                            initialValue: widget.property!.address!.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              hintText: "Escriba la dirección de la propiedad",
                            ));
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: BrandColors.hof,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Departamento",
                      style: TextStyle(color: BrandColors.hof),
                    ),
                  ]),
                  StreamBuilder(
                      stream: _propertyBloc.departamentoStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xfff6f6f6),
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            isExpanded: true,
                            hint: const Center(
                                child: Text("Seleccione departamento")),
                            items: departamentosList.map((item) {
                              return DropdownMenuItem(
                                value: item.id.toString(),
                                child: Center(
                                  child: Text(item.nombre.toString()),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                departamentoSelected = value.toString();
                                distritoSelected = "";
                                municipioSelected = "";
                                _propertyBloc.changeDistrito("");
                                _propertyBloc.changeMunicipio("");
                                distritosList = [];
                                municipiosList = [];
                              });
                              getMunicipiosData(departamentoSelected);
                            },
                            value: departamentoSelected,
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: BrandColors.hof,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Municipio",
                      style: TextStyle(color: BrandColors.hof),
                    ),
                  ]),
                  StreamBuilder(
                      stream: _propertyBloc.municipioStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xfff6f6f6),
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            isExpanded: true,
                            hint: const Center(
                                child: Text("Seleccione municipio")),
                            items: municipiosList.map((item) {
                              return DropdownMenuItem(
                                value: item.id.toString(),
                                child: Center(
                                  child: Text(item.nombre.toString()),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _propertyBloc.changeMunicipio(value.toString());

                              setState(() {
                                municipioSelected = value.toString();
                                distritoSelected = "";
                                _propertyBloc.changeDistrito("");
                              });
                              getDistritosData(municipioSelected);
                            },
                            value: municipioSelected.isNotEmpty
                                ? municipioSelected
                                : null,
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: BrandColors.hof,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Distrito",
                      style: TextStyle(color: BrandColors.hof),
                    ),
                  ]),
                  StreamBuilder(
                      stream: _propertyBloc.distritoStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xfff6f6f6),
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            isExpanded: true,
                            hint: const Center(
                                child: Text("Seleccione un distrito")),
                            items: distritosList.map((item) {
                              return DropdownMenuItem(
                                value: item.id.toString(),
                                child: Center(
                                  child: Text(item.nombre.toString()),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _propertyBloc.changeDistrito(value.toString());

                              setState(() {
                                distritoSelected = value.toString();
                              });
                            },
                            value: distritoSelected.isNotEmpty
                                ? distritoSelected
                                : null,
                          ),
                        );
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
                        return TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            onChanged: _propertyBloc.changeBedrooms,
                            initialValue: widget.property!.bedrooms!.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              //hintText: "Escriba la dirección de la propiedad",
                            ));
                      }),
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
                        return TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            onChanged: _propertyBloc.changeBeds,
                            initialValue: widget.property!.beds!.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              //hintText: "Escriba la dirección de la propiedad",
                            ));
                      }),
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
                        return TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            onChanged: _propertyBloc.changeBathrooms,
                            initialValue:
                                widget.property!.bathrooms!.toString(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              //hintText: "Escriba la dirección de la propiedad",
                            ));
                      }),
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
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.wifiStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene wifi?'),
                          value: wifi,
                          onChanged: (bool value) {
                            setState(() {
                              wifi = value;
                            });
                          },
                          secondary: const Icon(Icons.wifi_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.airConditionerStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene aire acondicionado?'),
                          value: ac,
                          onChanged: (bool value) {
                            setState(() {
                              ac = value;
                            });
                          },
                          secondary: const Icon(Icons.ac_unit_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.kitchenStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene cocina?'),
                          value: kitchen,
                          onChanged: (bool value) {
                            setState(() {
                              kitchen = value;
                            });
                          },
                          secondary: const Icon(Symbols.stockpot),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.dinningStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene mesa de comedor?'),
                          value: dinningTable,
                          onChanged: (bool value) {
                            setState(() {
                              dinningTable = value;
                            });
                          },
                          secondary: const Icon(Symbols.flatware),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.dishSinkStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene lavatrastos?'),
                          value: sink,
                          onChanged: (bool value) {
                            setState(() {
                              sink = value;
                            });
                          },
                          secondary: const Icon(Icons.countertops_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.fridgeStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene refrigeradora?'),
                          value: fridge,
                          onChanged: (bool value) {
                            setState(() {
                              fridge = value;
                            });
                          },
                          secondary: const Icon(Icons.kitchen_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.tvStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene televisión?'),
                          value: tv,
                          onChanged: (bool value) {
                            setState(() {
                              tv = value;
                            });
                          },
                          secondary: const Icon(Icons.tv_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.furnitureStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene muebles de sala?'),
                          value: furniture,
                          onChanged: (bool value) {
                            setState(() {
                              furniture = value;
                            });
                          },
                          secondary: const Icon(Icons.weekend_outlined),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                      stream: _propertyBloc.garageStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return SwitchListTile(
                          activeColor: BrandColors.fty,
                          title: const Text('¿Tiene cochera?'),
                          value: garage,
                          onChanged: (bool value) {
                            setState(() {
                              garage = value;
                            });
                          },
                          secondary: const Icon(Icons.garage_outlined),
                        );
                      }),
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
                                  style: TextStyle(color: BrandColors.foggy),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            _propertyBloc
                                .changeWifi((wifi == true ? 1 : 0).toString());
                            _propertyBloc.changeDinning(
                                (dinningTable == true ? 1 : 0).toString());
                            _propertyBloc.changeAirConditioner(
                                (ac == true ? 1 : 0).toString());
                            _propertyBloc.changeKitchen(
                                (kitchen == true ? 1 : 0).toString());
                            _propertyBloc.changeDishSink(
                                (sink == true ? 1 : 0).toString());
                            _propertyBloc.changeFridge(
                                (fridge == true ? 1 : 0).toString());
                            _propertyBloc
                                .changeTv((tv == true ? 1 : 0).toString());
                            _propertyBloc.changeFurniture(
                                (furniture == true ? 1 : 0).toString());
                            _propertyBloc.changeGarage(
                                (garage == true ? 1 : 0).toString());

                            _propertyBloc.updateProperty(
                                widget.property!.id, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BrandColors.fty,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Actualizar datos",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white)),
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
            ),
          )),
        ));
  }
}
