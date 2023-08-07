// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/lease_bloc.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/lease/edit_lease.dart';
import 'package:home_management_app/ui/screens/property/create_payment_receipt.dart';
import 'package:home_management_app/ui/widgets/tenant_info_container.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';

class LeaseDetailsScreen extends StatefulWidget {
  final leaseId;
  const LeaseDetailsScreen({super.key, required this.leaseId});

  @override
  State<LeaseDetailsScreen> createState() => _LeaseDetailsScreenState();
}

class _LeaseDetailsScreenState extends State<LeaseDetailsScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();
  final LeaseBloc leaseBloc = LeaseBloc();
  bool loader = false;
  late final Future getPayments;
  Future? getLeaseDetails;
  late String accessToken;

  PaymentsDetails? payments;
  Lease? lease;

  Future<List<PaymentsDetails>> _getPayments() async {
    final getPaymentsDetails =
        await _propertiesBloc.getPayments(widget.leaseId);

    return getPaymentsDetails;
  }

  Future<bool> _getLeaseDetails() async {
    final getLease = await _propertiesBloc.getLeaseDetails(widget.leaseId);

    setState(() {
      loader = true;
      lease = getLease;
    });
    return loader;
  }

  @override
  void initState() {
    super.initState();
    getPayments = _getPayments();
    getLeaseDetails = _getLeaseDetails();
    accessToken =
        UserPreferences.getAccessToken() ?? "Falló obtener AccessToken";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              if (lease?.active == true)
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateReceiptScreen(
                                  lease: lease,
                                ))).then((value) => _getLeaseDetails());
                  },
                  backgroundColor: BrandColors.rausch,
                  child: const Icon(Icons.add_outlined),
                )
            ]),
            appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                actions: [
                  if (lease?.active == true)
                    PopupMenuButton(
                      onSelected: (value) {},
                      itemBuilder: (BuildContext ctx) {
                        return [
                          PopupMenuItem(
                            //Yeah this is the only way
                            //to navigate without a named route:
                            //https://github.com/flutter/flutter/issues/87766
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const EditLeaseScreen(
                                          //property: propertyDetails,
                                          );
                                    },
                                  ),
                                );
                              });
                            },
                            child: const Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: BrandColors.hof,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Editar",
                                      style: TextStyle(color: BrandColors.hof),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                testDialogBuilder(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return const TerminateLeaseScreen(
                                //           //property: propertyDetails,
                                //           );
                                //     },
                                //   ),
                                // );
                              });
                              // leaseBloc
                              //     .endLease(lease!.id, context)
                              //     .then((value) => _getLeaseDetails());
                            },
                            child: const Column(children: [
                              Row(children: [
                                Icon(
                                  Icons.delete_forever_outlined,
                                  color: BrandColors.hof,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Finalizar contrato",
                                  style: TextStyle(color: BrandColors.hof),
                                )
                              ])
                            ]),
                          )
                        ];
                      },
                    ),
                ]),
            body: FutureBuilder(
              future: getLeaseDetails,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        RefreshIndicator(
                          onRefresh: () {
                            return _getLeaseDetails();
                          },
                          child: TenantInfoContainer(
                            lease: lease,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return CustomDialogs.navigationLoader("Cargando...");
                }
              }),
            )));
  }

  Future<void> testDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finalizar contrato'),
          content: SingleChildScrollView(
            child: SizedBox(
              //height: MediaQuery.of(context).size.height / 6.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(children: [
                    Icon(
                      Icons.comment_outlined,
                      color: BrandColors.hof,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Observaciones",
                      style: TextStyle(color: BrandColors.hof),
                    ),
                  ]),
                  StreamBuilder(
                      stream: leaseBloc.leaseTerminationCommentsStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        return TextFormField(
                            onChanged: leaseBloc.changeLeaseTerminationComments,
                            minLines: 2,
                            maxLines: null,
                            //initialValue: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                            ));
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                //  getPersonalInfo();
                Navigator.of(context).pop();
              },
            ),
            StreamBuilder(
                stream: leaseBloc.verifyLeaseComments,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        onPressed: null,
                        child: const Text('Continuar'));
                  } else {
                    return TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Continuar'),
                      onPressed: () {
                        leaseBloc
                            .endLease(lease!.id, context)
                            .then((value) => _getLeaseDetails());
                      },
                    );
                  }
                })
          ],
        );
      },
    );
  }
}
