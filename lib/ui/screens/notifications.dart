import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
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
            Container(
              child: Icon(Icons.apps),
            ),
            Icon(Icons.movie),
          ]),
        ));
  }
}
