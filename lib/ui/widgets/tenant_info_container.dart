import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/widgets/view_payment_details.dart';

class TenantInfoContainer extends StatelessWidget {
  final Lease? lease;
  const TenantInfoContainer({super.key, required this.lease});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(children: [
            Text("${lease!.tenantId!.name} ${lease!.tenantId!.lastname}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: BrandColors.loft, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (lease!.active == true)
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: BrandColors.rausch,
                  ),
                if (lease!.active == true)
                  const SizedBox(
                    width: 2,
                  ),
                const Text(
                  "Arrendatario",
                  style: TextStyle(color: BrandColors.foggy),
                )
              ],
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(
              Icons.home_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              lease!.propertyId!.name.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.phone_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              lease!.tenantId!.phone.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Inicio: ${lease!.contractDate}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Finalización: ${lease!.expirationDate}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.today_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Fecha de cobro: ${lease!.paymentDate}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.payments_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Cantidad: \$${lease!.price}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Historial de pagos",
            style: TextStyle(color: BrandColors.foggy, fontSize: 18)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.86,
            child: ListView.builder(
              itemCount: lease!.payments!.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () {},
                  child: ListView(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 0, top: 0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 9.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                              offset: Offset(0, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentDetailsScreen(
                                        paymentDetails: lease!.payments![i],
                                        tenantName: lease!.tenantId!.name,
                                        tenantLastname:
                                            lease!.tenantId!.lastname,
                                      ))),
                          leading: Container(
                            padding: const EdgeInsets.all(9.0),
                            decoration: const BoxDecoration(
                                color: BrandColors.rausch,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.receipt_long_outlined,
                                color: Colors.white),
                          ),
                          title: Text(
                              "Recibo #${lease!.payments![i].receiptNumber}"),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "Cantidad: \$${lease!.payments![i].payment}")
                                ],
                              ),
                              /*
                              Row(
                                children: [
                                  Text(
                                      "Fecha de pago: ${lease!.payments![i].paymentDate}")
                                ],
                              ),*/
                              Row(
                                children: [
                                  Text(
                                      "Correspondiente al mes de: ${lease!.payments![i].monthCancelledName}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
      ],
    );
  }
}
