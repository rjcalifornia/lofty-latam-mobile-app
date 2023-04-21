// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/screens/property/property_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PropertiesContainer extends StatelessWidget {
  final int id;

  final token;
  final property;
  const PropertiesContainer(
      {super.key,
      required this.id,
      required this.property,
      required this.token});

  Future<String?> getImage() async {
    return Future.delayed(const Duration(milliseconds: 2000), () {
      return property[id]['property_pictures']['image_link_name'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PropertyDetailsScreen(
                      id: property[id]['id'],
                      accessToken: token,
                    ))),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(boxShadow: const [
                        //BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 3))
                      ], borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.withOpacity(.3),
                                    BlendMode.srcOver),
                                image: NetworkImage(
                                    property[id]['property_pictures']
                                            ['image_link_name']
                                        .toString(),
                                    headers: {
                                      'Authorization': 'Bearer $token'
                                    }),
                                fit: BoxFit.cover),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${property[id]['name']}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                } else {
                  return LoadingAnimationWidget.staggeredDotsWave(
                      color: BrandColors.arches, size: 26);
                }
              },
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: [
                    Text("${property[id]['address']}",
                        style: const TextStyle(color: BrandColors.foggy))
                  ],
                ))
              ],
            ),
            const SizedBox(height: 3),
            /*
        Row(
          children: const <Widget>[
            Text(
              "Precio de la propiedad",
              style: (TextStyle(color: Color.fromARGB(255, 151, 155, 156))),
            )
          ],
        ),*/
            const SizedBox(height: 6),
            const Divider(
              height: 21,
              color: BrandColors.hof,
            ),
            const SizedBox(height: 6),
          ],
        ));
  }
}
