import 'package:flutter/material.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';

import 'package:home_management_app/global.dart';
import 'package:home_management_app/bloc/payments_bloc.dart';
import 'package:provider/provider.dart';

class CreateReceiptScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final lease;
  const CreateReceiptScreen({super.key, required this.lease});

  @override
  State<CreateReceiptScreen> createState() => _CreateReceiptScreenState();
}

class _CreateReceiptScreenState extends State<CreateReceiptScreen> {
  final PaymentsBloc _paymentsBloc = PaymentsBloc();
  late List monthsList = [];

  List<PaymentType> paymentType = [];

  Future _getReceiptData() async {
    final monthsJson = await _paymentsBloc.obtenerMeses();
    final paymentTypeJson = await _paymentsBloc.getReceiptType();
    setState(() {
      monthsList = monthsJson;
      paymentType = paymentTypeJson;
    });
    //print(paymentType![0].name);
  }

  @override
  void initState() {
    super.initState();
    _getReceiptData();
    //obtenerMeses();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //profileBloc.dispose() cannot call as ProfileBloc class doesn't have dispose method
    super.dispose();
    _paymentsBloc.paymentFieldsDispose();
  }

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of<PaymentsBloc>(context);
    String? selectedMonth;
    String? selectedPaymentType;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: BrandColors.hof),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 25.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(21.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(children: [
                const Text(
                  "Generar recibo",
                  style: TextStyle(
                    color: BrandColors.loft,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.lease!.propertyId.name.toString(),
                  style: const TextStyle(
                    color: BrandColors.rausch,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  "Mes a cancelar",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                    stream: _paymentsBloc.monthCancelledStream,
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
                            focusedBorder: InputBorder.none,
                          ),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          isExpanded: true,
                          hint: const Center(
                              child: Text("Seleccione el mes a cancelar")),
                          items: monthsList.map((item) {
                            //print(item['id']);
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Center(
                                child: Text(item['label']),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _paymentsBloc
                                .changeMonthCancelled(value.toString());
                            setState(() {
                              selectedMonth = value.toString();
                              // print(selectedMonth);
                              //print(selectedMonth);
                              //print(bloc.getMonthCancelled);
                            });
                          },
                          value: selectedMonth,
                        ),
                      );
                    }),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Tipo de pago",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                    stream: _paymentsBloc.paymentTypeStream,
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
                              child: Text("Seleccione el tipo de pago")),
                          items: paymentType.map((item) {
                            //print(item['id']);
                            return DropdownMenuItem(
                              value: item.id.toString(),
                              child: Center(
                                child: Text(item.name.toString()),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            //bloc.changeMonthCancelled(value.toString());
                            _paymentsBloc.changePaymentType(value.toString());
                            setState(() {
                              selectedPaymentType = value.toString();
                              // print(selectedMonth);
                              //print(selectedMonth);
                              //print(bloc.getMonthCancelled);
                            });
                          },
                          value: selectedPaymentType,
                        ),
                      );
                    }),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Cantidad",
                  style: TextStyle(color: BrandColors.hof),
                ),
                StreamBuilder(
                  stream: _paymentsBloc.paymentStream,
                  builder: (context, AsyncSnapshot snapshot) {
                    return TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: _paymentsBloc.changePayment,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f6f6),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: "Escriba la cantidad recibida",
                          //labelText: 'Escriba la cantidad recibida',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                StreamBuilder(
                  stream: _paymentsBloc.verifyPaymentData,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      // ignore: avoid_unnecessary_containers
                      return Container(
                        child: Column(
                          children: const [
                            Text(
                              "Complete todos los datos requeridos",
                              style: TextStyle(color: BrandColors.foggy),
                            )
                          ],
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          _paymentsBloc.generateReceipt(
                              context, widget.lease.id);
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
                            Icon(Icons.save_as_outlined, size: 28),
                            SizedBox(width: 8),
                            Text("Guardar pago",
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
              ]),
            ),
          )),
    );
  }
}
