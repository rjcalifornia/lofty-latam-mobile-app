// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/payments_bloc.dart';
import 'package:home_management_app/global.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final paymentDetails;
  final tenantName;
  final tenantLastname;
  final tenantEmail;

  const PaymentDetailsScreen({
    super.key,
    required this.paymentDetails,
    this.tenantLastname,
    this.tenantName,
    this.tenantEmail,
  });

  @override
  Widget build(BuildContext context) {
    final PaymentsBloc _paymentsBloc = PaymentsBloc();

    // adjust these to change header size / overlap amount
    const double headerHeight = 125;
    const double overlap = 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.fty,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "Detalles de pago",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // colored header background
            Container(
              height: headerHeight,
              width: double.infinity,
              color: BrandColors.fty,
            ),

            Transform.translate(
              offset: const Offset(0, -overlap),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xfff7f9ff),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${paymentDetails.leaseId?.tenantId?.name ?? ''}",
                      style: const TextStyle(
                          fontSize: 22,
                          color: BrandColors.hof,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${paymentDetails.leaseId?.tenantId?.lastname ?? ''}",
                      style: const TextStyle(
                          fontSize: 22,
                          color: BrandColors.hof,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 18),
                    const Text("Número de recibo",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "${paymentDetails.receiptNumber ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 8),
                    const Text("Tipo de pago",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "${paymentDetails.paymentTypeId?.name ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 8),
                    const Text("Fecha de pago",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "${paymentDetails.paymentDate ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 8),
                    const Text("Cantidad",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "\$${paymentDetails.payment ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 8),
                    const Text("Pago correspondiente al mes de",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "${paymentDetails.monthCancelledName ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 8),
                    const Text("Recibo emitido por",
                        style:
                            TextStyle(fontSize: 14, color: BrandColors.foggy)),
                    Text(
                      "${paymentDetails.leaseId?.propertyId?.landlordId?.name ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    Text(
                      "${paymentDetails.leaseId?.propertyId?.landlordId?.lastname ?? ''}",
                      style: const TextStyle(
                          fontSize: 20, color: BrandColors.loft),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () {
                        _paymentsBloc.downloadReceipt(
                            context, paymentDetails.id);
                      },
                      color: BrandColors.fty,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Descargar recibo',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    if (tenantEmail != null) ...[
                      const SizedBox(height: 12),
                      MaterialButton(
                        onPressed: () {
                          _paymentsBloc.sendPaymentReceipt(
                              context, paymentDetails.id);
                        },
                        color: BrandColors.babu,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child:
                            const Text('Enviar recibo por correo electrónico'),
                      ),
                    ],
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // bottom spacing so last content isn't flush to the edge
          ],
        ),
      ),
    );
  }
}
