// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/property/create_payment_receipt.dart';
import 'package:home_management_app/ui/widgets/tenant_info_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LeaseDetailsScreen extends StatefulWidget {
  final leaseId;
  const LeaseDetailsScreen({super.key, required this.leaseId});

  @override
  State<LeaseDetailsScreen> createState() => _LeaseDetailsScreenState();
}

class _LeaseDetailsScreenState extends State<LeaseDetailsScreen> {
  final PropertiesBloc _propertiesBloc = PropertiesBloc();
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateReceiptScreen(
                              lease: lease,
                            )));
              },
              backgroundColor: BrandColors.rausch,
              child: const Icon(Icons.add_outlined),
            ),
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
}
