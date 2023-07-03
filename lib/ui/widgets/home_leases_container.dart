// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/screens/lease/lease_details.dart';

class HomeLeasesContainer extends StatelessWidget {
  final propertyDetails;
  const HomeLeasesContainer({super.key, required this.propertyDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: propertyDetails!.leases!.length,
          itemBuilder: (ctx, i) {
            return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaseDetailsScreen(
                              leaseId: propertyDetails.leases[i].id,
                            ))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: BrandColors.rausch,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/img/contract.png",
                                        height: 80,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: BrandColors.foggy,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${propertyDetails!.leases![i].tenantId!.name} ${propertyDetails!.leases![i].tenantId!.lastname}",
                              style: const TextStyle(color: BrandColors.foggy),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (propertyDetails!.leases![i].active == true)
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                color: BrandColors.rausch,
                              ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "\$${propertyDetails!.leases![i].price}",
                              style: const TextStyle(
                                  color: BrandColors.loft,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )));
          }),
    );
  }
}
