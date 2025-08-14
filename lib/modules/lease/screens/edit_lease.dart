import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/lease_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentClass.dart';
import 'package:home_management_app/modules/property/models/RentClass.dart';
import 'package:home_management_app/ui/utils/datepickerField.dart';

class EditLeaseScreen extends StatefulWidget {
  final Lease? lease;
  const EditLeaseScreen({super.key, required this.lease});

  @override
  State<EditLeaseScreen> createState() => _EditLeaseScreenState();
}

class _EditLeaseScreenState extends State<EditLeaseScreen> {
  final LeaseBloc _leaseBloc = LeaseBloc();

  late String selectedRentClass = widget.lease!.rentType!.id.toString();
  late String selectedPaymentClass =
      widget.lease!.paymentClassId!.id.toString();
  late String selectedPrice = widget.lease!.price.toString();

  late DateTime selectedPaymentDate =
      DateTime.parse(widget.lease!.paymentDate.toString());

  late DateTime selectedExpirationDate =
      DateTime.parse(widget.lease!.expirationDate.toString());

  late DateTime selectedContractDate =
      DateTime.parse(widget.lease!.contractDate.toString());

  dynamic paymentDate = TextEditingController();
  dynamic contractDate = TextEditingController();
  dynamic expirationDate = TextEditingController();

  List<RentClass> rentClass = [];
  List<PaymentClass> paymentClass = [];

  Future? getLeaseDetails;

  Future _getLeaseData() async {
    final rentClassJson = await _leaseBloc.getRentClass();
    final paymentClassJson = await _leaseBloc.getPaymentClass();
    setState(() {
      rentClass = rentClassJson;
      paymentClass = paymentClassJson;
      contractDate.text = selectedContractDate.toIso8601String().split('T')[0];
      paymentDate.text = selectedPaymentDate.toIso8601String().split('T')[0];
      expirationDate.text =
          selectedExpirationDate.toIso8601String().split('T')[0];
    });
    return rentClass;
  }

  void setValues() {
    setState(() {
      _leaseBloc.changeRentClass(widget.lease!.rentType!.id.toString());
      _leaseBloc
          .changePaymentClass(widget.lease!.paymentClassId!.id.toString());
      _leaseBloc.changeContractDate(
          selectedContractDate.toIso8601String().split('T')[0]);
      _leaseBloc.changePaymentDate(
          selectedPaymentDate.toIso8601String().split('T')[0]);
      _leaseBloc.changeExpirationDate(
          selectedExpirationDate.toIso8601String().split('T')[0]);
      _leaseBloc.changePrice(widget.lease!.price.toString());
    });
  }

  @override
  void initState() {
    getLeaseDetails = _getLeaseData();
    setValues();
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
          child: FutureBuilder(
              future: getLeaseDetails,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Editar contrato",
                              style: TextStyle(
                                  color: BrandColors.foggy,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 12,
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      isExpanded: true,
                                      hint: const Center(
                                          child: Text(
                                              "Seleccione el tipo de alquiler")),
                                      items: rentClass.map((item) {
                                        return DropdownMenuItem(
                                          value: item.id.toString(),
                                          child: Center(
                                            child: Text(item.name.toString()),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _leaseBloc
                                            .changeRentClass(value.toString());
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
                            const Text(
                              "Modalidad de pago",
                              style: TextStyle(color: BrandColors.hof),
                            ),
                            StreamBuilder(
                                stream: _leaseBloc.paymentClassStream,
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      isExpanded: true,
                                      hint: const Center(
                                          child: Text(
                                              "Seleccione modalidad de pago")),
                                      items: paymentClass.map((item) {
                                        return DropdownMenuItem(
                                          value: item.id.toString(),
                                          child: Center(
                                            child: Text(item.name.toString()),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _leaseBloc.changePaymentClass(
                                            value.toString());
                                        setState(() {
                                          selectedPaymentClass =
                                              value.toString();
                                        });
                                      },
                                      value: selectedPaymentClass,
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 22,
                            ),
                            // StreamBuilder(
                            //     stream: _leaseBloc.contractDateStream,
                            //     builder: (context, AsyncSnapshot snapshot) {
                            //       return DatePickerField(
                            //         selectedPickerDate: selectedContractDate,
                            //         textController: contractDate,
                            //         labelText:
                            //             'Seleccione fecha de inicio de contrato',
                            //         dateFieldChange:
                            //             _leaseBloc.changeContractDate,
                            //       );
                            //     }),
                            // const SizedBox(
                            //   height: 22,
                            // ),
                            // StreamBuilder(
                            //     stream: _leaseBloc.paymentDateStream,
                            //     builder: (context, AsyncSnapshot snapshot) {
                            //       return DatePickerField(
                            //         selectedPickerDate: selectedPaymentDate,
                            //         textController: paymentDate,
                            //         labelText: 'Seleccione fecha de pago',
                            //         dateFieldChange:
                            //             _leaseBloc.changePaymentDate,
                            //       );
                            //     }),
                            // const SizedBox(
                            //   height: 22,
                            // ),
                            StreamBuilder(
                                stream: _leaseBloc.expirationDateStream,
                                builder: (context, AsyncSnapshot snapshot) {
                                  return DatePickerField(
                                    selectedPickerDate: selectedExpirationDate,
                                    textController: expirationDate,
                                    labelText: 'Finalización de contrato',
                                    dateFieldChange:
                                        _leaseBloc.changeExpirationDate,
                                  );
                                }),
                            const SizedBox(
                              height: 22,
                            ),
                            // const Row(
                            //   children: [
                            //     Icon(
                            //       Icons.payment_outlined,
                            //       color: BrandColors.hof,
                            //       size: 14,
                            //     ),
                            //     SizedBox(
                            //       width: 2,
                            //     ),
                            //     Text(
                            //       "Pago de alquiler mensual",
                            //       style: TextStyle(color: BrandColors.hof),
                            //     ),
                            //   ],
                            // ),
                            // StreamBuilder(
                            //     stream: _leaseBloc.priceStream,
                            //     builder: (context, AsyncSnapshot snapshot) {
                            //       return TextFormField(
                            //         initialValue:
                            //             widget.lease!.price.toString(),
                            //         keyboardType:
                            //             const TextInputType.numberWithOptions(
                            //                 decimal: true),
                            //         onChanged: _leaseBloc.changePrice,
                            //         decoration: InputDecoration(
                            //             filled: true,
                            //             fillColor: const Color(0xfff6f6f6),
                            //             border: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(15),
                            //                 borderSide: BorderSide.none),
                            //             errorText: snapshot.hasError
                            //                 ? snapshot.error.toString()
                            //                 : null),
                            //       );
                            //     }),
                            // const SizedBox(
                            //   height: 22,
                            // ),
                            StreamBuilder(
                                stream: _leaseBloc.verifyEditLeaseFields,
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox(
                                      child: Column(
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
                                        _leaseBloc.updateLease(
                                            widget.lease!.id, context);
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
                                          Text("Actualizar contrato",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ]),
                    ),
                  );
                } else {
                  return CustomDialogs.navigationLoader("Espere por favor...");
                }
              })),
        ),
      ),
    );
  }
}
