import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';

class EditPropertyScreen extends StatefulWidget {
  final Property? property;
  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final PropertiesBloc _propertyBloc = PropertiesBloc();

  @override
  Widget build(BuildContext context) {
    _propertyBloc.changeName(widget.property!.name!.toString());
    _propertyBloc.changeAddress(widget.property!.address!.toString());
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
                ElevatedButton(
                    onPressed: () {
                      print(_propertyBloc.name);
                    },
                    child: Text('Prueba'))
              ],
            ),
          )),
        ));
  }
}
