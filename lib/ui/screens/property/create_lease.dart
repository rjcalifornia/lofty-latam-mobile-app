import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/RentClass.dart';
import 'package:home_management_app/bloc/lease_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';
import 'package:home_management_app/ui/utils/datepickerField.dart';
import 'package:home_management_app/ui/utils/moneyField.dart';

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
  DateTime selectedPaymentDate = DateTime.now();
  DateTime selectedExpirationDate = DateTime.now();

  dynamic contractDate = TextEditingController();
  dynamic paymentDate = TextEditingController();
  dynamic expirationDate = TextEditingController();

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
                      const SizedBox(
                        height: 22,
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.contractDateStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            return DatePickerField(
                              selectedPickerDate: selectedContractDate,
                              textController: contractDate,
                              labelText:
                                  'Seleccione fecha de inicio de contrato',
                              dateFieldChange: _leaseBloc.changeContractDate,
                            );
                          }),
                      const SizedBox(
                        height: 22,
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.paymentDateStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            return DatePickerField(
                              selectedPickerDate: selectedPaymentDate,
                              textController: paymentDate,
                              labelText: 'Seleccione fecha de pago',
                              dateFieldChange: _leaseBloc.changePaymentDate,
                            );
                          }),
                      const SizedBox(
                        height: 22,
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.expirationDateStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            return DatePickerField(
                              selectedPickerDate: selectedExpirationDate,
                              textController: expirationDate,
                              labelText: 'Finalización de contrato',
                              dateFieldChange: _leaseBloc.changeExpirationDate,
                            );
                          }),
                      const SizedBox(
                        height: 22,
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.priceStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            return MoneyField(
                              changeStream: _leaseBloc.changePrice,
                              snapshot: snapshot,
                              labelText: 'Pago mensual',
                            );
                          }),
                      const SizedBox(
                        height: 22,
                      ),
                      StreamBuilder(
                          stream: _leaseBloc.depositStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            return MoneyField(
                              changeStream: _leaseBloc.changeDeposit,
                              snapshot: snapshot,
                              labelText: 'Depósito',
                            );
                          }),
                      const SizedBox(
                        height: 22,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          print(_leaseBloc.contractDate.toString());
                          print(_leaseBloc.paymentDate.toString());
                          print(_leaseBloc.expirationDate.toString());
                          print(_leaseBloc.price.toString());
                        },
                        child: Text('TextButton'),
                      )
                    ]))));
  }
}
