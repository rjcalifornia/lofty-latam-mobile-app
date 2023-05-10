// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/payments_bloc.dart';
import 'package:home_management_app/global.dart';
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
            FutureBuilder(
                future: loadNotifications,
                builder: (((context, snapshot) {
                  if (snapshot.hasData) {
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
                                  color: Color(0xffe6e1ff),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Icon(Icons.warning_outlined),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Text(
                                          notifications![i].toString(),
                                          style: TextStyle(
                                              color: BrandColors.foggy,
                                              fontSize: 16),
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
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: BrandColors.arches, size: 28),
                    );
                  }
                }))),
            Icon(Icons.movie),
          ]),
        ));
  }
}
