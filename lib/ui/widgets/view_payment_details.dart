import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final paymentDetails;
  const PaymentDetailsScreen({super.key, required this.paymentDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: BrandColors.rausch,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(""),
            ),
            
            );
  }
}
