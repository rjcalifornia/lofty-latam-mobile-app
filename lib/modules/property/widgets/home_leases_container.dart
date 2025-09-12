// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class HomeLeasesContainer extends StatelessWidget {
  final propertyDetails;
  final iterator;
  const HomeLeasesContainer(
      {super.key, required this.propertyDetails, required this.iterator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: BrandColors.fty,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      "${propertyDetails!.leases![iterator].tenantId!.name} ${propertyDetails!.leases![iterator].tenantId!.lastname}",
                      style: const TextStyle(color: BrandColors.foggy),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (propertyDetails!.leases![iterator].active == true)
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: BrandColors.rausch,
                      ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "\$${propertyDetails!.leases![iterator].price}",
                      style: const TextStyle(
                          color: BrandColors.loft, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (propertyDetails!.leases![iterator].active == false)
                  const Row(
                    children: [
                      Icon(
                        Icons.done_outlined,
                        color: BrandColors.rausch,
                      ),
                      Text(
                        "Contrato finalizado",
                        style: TextStyle(
                            color: BrandColors.rausch,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
              ],
            )));
  }
}
