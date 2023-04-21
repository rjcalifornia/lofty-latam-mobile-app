import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class HomeServicesContainer extends StatelessWidget {
  final propertyDetails;
  const HomeServicesContainer({
    super.key,
    required this.propertyDetails,
  });

  @override
  Widget build(BuildContext context) {
    bool? hasDinningRoom = propertyDetails?.hasDinningRoom;
    bool? hasKitchen = propertyDetails?.hasKitchen;
    bool? hasSink = propertyDetails?.hasSink;
    bool? hasWifi = propertyDetails?.hasWifi;
    bool? hasTv = propertyDetails?.hasTv;
    bool? hasFurniture = propertyDetails?.hasFurniture;
    bool? hasAc = propertyDetails?.hasAc;
    bool? hasGarage = propertyDetails?.hasGarage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              Icons.home_outlined,
              color: BrandColors.foggy,
            ),
            const SizedBox(width: 8),
            Text(
              "Tipo Alojamiento: Alquiler Extendido",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: BrandColors.foggy),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Amenidades",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: BrandColors.loft, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 6,
        ),
        const SizedBox(
          height: 6,
        ),
        if (hasDinningRoom == true)
          Row(
            children: [
              const Icon(
                Icons.table_bar_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Comedor',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasKitchen == true)
          Row(
            children: [
              const Icon(
                Icons.dining_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Cocina',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasSink == true)
          Row(
            children: [
              const Icon(
                Icons.flatware_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Lavatrastos',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasWifi == true)
          Row(
            children: [
              const Icon(
                Icons.wifi_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Wifi',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasTv == true)
          Row(
            children: [
              const Icon(
                Icons.tv_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Televisor',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasFurniture == true)
          Row(
            children: [
              const Icon(
                Icons.living_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Amueblada',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasAc == true)
          Row(
            children: [
              const Icon(
                Icons.ac_unit_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Aire acondicionado',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (hasGarage == true)
          Row(
            children: [
              const Icon(
                Icons.garage_outlined,
                color: BrandColors.foggy,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Cochera',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BrandColors.foggy, fontSize: 16),
              ),
            ],
          ),
      ],
    );
  }
}
