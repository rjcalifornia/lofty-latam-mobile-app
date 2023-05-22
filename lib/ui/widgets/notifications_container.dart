import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationsContainer extends StatelessWidget {
  final List? notifications;
  Future? loadNotifications;
  NotificationsContainer(
      {super.key, this.notifications, this.loadNotifications});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadNotifications,
        builder: (((context, snapshot) {
          if (snapshot.hasData) {
            if (notifications!.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: const [
                        Text(
                          "No hay notificaciones pendientes",
                          style:
                              TextStyle(color: BrandColors.foggy, fontSize: 18),
                        )
                      ],
                    ))
                  ],
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: notifications?.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: const Color(0xffe6e1ff),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: const Icon(Icons.warning_outlined),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    notifications![i].toString(),
                                    style: const TextStyle(
                                        color: BrandColors.foggy, fontSize: 16),
                                  )
                                ],
                              ))
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: BrandColors.arches, size: 28),
            );
          }
        })));
  }
}
