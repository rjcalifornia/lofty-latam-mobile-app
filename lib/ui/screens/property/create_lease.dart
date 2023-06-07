import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/RentClass.dart';
import 'package:home_management_app/bloc/lease_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';

class CreateLeaseScreen extends StatefulWidget {
  final Property? property;
  const CreateLeaseScreen({super.key, required this.property});

  @override
  State<CreateLeaseScreen> createState() => _CreateLeaseScreenState();
}

class _CreateLeaseScreenState extends State<CreateLeaseScreen> {
  final LeaseBloc _leaseBloc = LeaseBloc();
  List<RentClass> rentClass = [];
  Future _getLeaseData() async {
    final rentClassJson = await _leaseBloc.getRentClass();
    setState(() {
      rentClass = rentClassJson;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLeaseData();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedRentClass;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: BrandColors.rausch,
              elevation: 0,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 18, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Nuevo contrato para ${widget.property!.name}",
                          style: const TextStyle(
                              color: BrandColors.hof, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const Text(
                        "Tipo de alquiler",
                        style: TextStyle(color: BrandColors.hof),
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.rentClassStream,
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
                                    child:
                                        Text("Seleccione el tipo de alquiler")),
                                items: rentClass.map((item) {
                                  return DropdownMenuItem(
                                    value: item.id.toString(),
                                    child: Center(
                                      child: Text(item.name.toString()),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _leaseBloc.changeRentClass(value.toString());
                                  setState(() {
                                    selectedRentClass = value.toString();
                                  });
                                },
                                value: selectedRentClass,
                              ),
                            );
                          }),


                          
                    ]))));
  }
}
