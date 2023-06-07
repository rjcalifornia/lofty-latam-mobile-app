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
  DateTime selectedContractDate = DateTime.now();
  var contractDate = TextEditingController();

  Future _getLeaseData() async {
    final rentClassJson = await _leaseBloc.getRentClass();
    setState(() {
      rentClass = rentClassJson;
    });
  }

  Future<void> _selectContractDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        initialDate: selectedContractDate,
        firstDate: DateTime(2021, 8),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: BrandColors.rausch,
                  secondary: BrandColors.arches,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!);
        });

    if (picked != null && picked != selectedContractDate) {
      setState(() {
        _leaseBloc.changeContractDate(picked.toString());
        selectedContractDate = picked;

        contractDate.text = picked.toIso8601String().split('T')[0];
      });
    }
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
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: GestureDetector(
                          onTap: () => _selectContractDate(context),
                          child: AbsorbPointer(
                            child: TextField(
                              style: const TextStyle(
                                color: Color(0xff313945),
                              ),
                              controller: contractDate,
                              decoration: const InputDecoration(
                                  labelText: 'Seleccione de contrato',
                                  prefixIcon: Icon(Icons.calendar_today)),
                            ),
                          ),
                        ),
                      )
                    ]))));
  }
}
