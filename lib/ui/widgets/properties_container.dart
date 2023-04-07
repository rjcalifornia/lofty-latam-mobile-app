import 'package:flutter/material.dart';

class PropertiesContainer extends StatelessWidget {
  final int id;
  const PropertiesContainer({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                          Colors.grey.withOpacity(.3), BlendMode.srcOver),
                      image: const NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/11/18/17/20/living-room-1835923_1280.jpg"),
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
                        "Nombre de la Propiedad",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(color: Colors.white, fontWeightDelta: 2),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 14,
        ),
        Row(
          children: const <Widget>[
            Text("Dirección de la propiedad",
                style: (TextStyle(color: Color.fromARGB(255, 151, 155, 156))))
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: const <Widget>[
            Text(
              "Precio de la propiedad",
              style: (TextStyle(color: Color.fromARGB(255, 151, 155, 156))),
            )
          ],
        ),
        const SizedBox(height: 6),
        const Divider(
          height: 21,
          color: Color.fromARGB(255, 151, 155, 156),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
