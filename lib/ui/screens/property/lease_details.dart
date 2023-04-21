// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/properties_bloc.dart';
import 'package:home_management_app/classes/UserPreferences.dart';
import 'package:home_management_app/models/Payments.dart';
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
  late String accessToken;

  Payments? payments;

  Future<List<Payments>> _getPayments() async {
    //print(widget.leaseId);
    final getPaymentsDetails =
        await _propertiesBloc.getPayments(widget.leaseId);
    setState(() {
      loader = true;
      //getPayments = getPaymentsDetails;
    });
    return getPaymentsDetails;
  }

  @override
  void initState() {
    super.initState();
    getPayments = _getPayments();
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
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            body: FutureBuilder(
              future: getPayments,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Column(children: [
                          Text(getPayments),
                        ],)
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: const Color(0xffff385c), size: 28),
                  );
                }
              }),
            )));
  }
}
