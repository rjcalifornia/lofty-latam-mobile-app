import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/lease_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentClass.dart';
import 'package:home_management_app/models/RentClass.dart';

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

  dynamic paymentDate = TextEditingController();
  dynamic expirationDate = TextEditingController();

  List<RentClass> rentClass = [];
  List<PaymentClass> paymentClass = [];

  Future _getLeaseData() async {
    final rentClassJson = await _leaseBloc.getRentClass();
    final paymentClassJson = await _leaseBloc.getPaymentClass();
    setState(() {
      rentClass = rentClassJson;
      paymentClass = paymentClassJson;
    });
    return rentClass;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getLeaseData();
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
              future: _getLeaseData(),
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
