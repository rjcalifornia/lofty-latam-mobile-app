import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';

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
          height: 12,
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
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: BrandColors.foggy,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lease!.propertyId!.address.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: BrandColors.foggy),
                      softWrap: true, // Allow the text to wrap to the next line
                    ),
                  )
                ],
              ),
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
        Row(
          children: [
            const Icon(
              Icons.credit_card_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Costo: \$${lease!.price}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        ListView.builder(
          itemCount: 14,
          shrinkWrap: true,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: () {},
              child: ListView(
                padding: EdgeInsets.zero,
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
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: const BoxDecoration(
                            color: BrandColors.rausch, shape: BoxShape.circle),
                        child: const Icon(Icons.payment_outlined,
                            color: Colors.white),
                      ),
                      title:
                          Text("Recibo #${lease!.payments![0].receiptNumber}"),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text("Cantidad: \$${lease!.payments![0].payment}")
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "Fecha de pago: ${lease!.payments![0].paymentDate}")
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "Correspondiente al mes de: ${lease!.payments![0].monthCancelledName}")
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
        )
      ],
    );
  }
}
