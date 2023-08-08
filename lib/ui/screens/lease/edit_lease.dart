import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';

class EditLeaseScreen extends StatefulWidget {
  final Lease? lease;
  const EditLeaseScreen({super.key, required this.lease});

  @override
  State<EditLeaseScreen> createState() => _EditLeaseScreenState();
}

class _EditLeaseScreenState extends State<EditLeaseScreen> {
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
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            ]),
          ),
        )),
      ),
    );
  }
}
