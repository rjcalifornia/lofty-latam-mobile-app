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
                                        decimal: true),
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
                                        decimal: true),
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
                                        decimal: true),
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
