// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/payments_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/widgets/notifications_container.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PaymentsBloc bloc = PaymentsBloc();
  bool loader = false;
  Future? loadNotifications;
  List? notifications;
  List? alerts;

  Future<bool> getNotifications() async {
    final getNotifications = await bloc.getPaymentNotifications();
    setState(() {
      loader = true;
      notifications = getNotifications['payment_notifications'];
      alerts = getNotifications['alerts'];
    });

    return loader;
  }

  @override
  void initState() {
    super.initState();
    loadNotifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: BrandColors.rausch,
            elevation: 0,
            bottom: const TabBar(
                labelColor: Colors.redAccent,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Notificaciones"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Alertas"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            NotificationsContainer(
              notifications: notifications,
              loadNotifications: loadNotifications,
            ),
            Icon(Icons.movie),
          ]),
        ));
  }
}
