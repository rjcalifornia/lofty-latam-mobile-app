import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeOptionsContainer extends StatelessWidget {
  final String countProperties;
  final getProperties;
  const HomeOptionsContainer(
      {super.key, required this.countProperties, required this.getProperties});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset("assets/img/home_banner.png"),
            ),
          ),
          Positioned.fill(
              child: Container(
            padding: const EdgeInsets.all(11.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffff385c).withOpacity(.24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Propiedades disponibles:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xfff5f6f5)),
                ),
                const SizedBox(
                  height: 4,
                ),
                FutureBuilder(
                  future: getProperties,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        countProperties.toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return LoadingAnimationWidget.waveDots(
                          color: const Color(0xffff385c), size: 26);
                    }
                  }),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    primary: Color(0xffff385c),
                  ),
                  onPressed: () {
                    /*
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(id: 0),
      ),
    );*/
                  },
                  child: const Text(
                    "Registrar nueva Propiedad",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xfff5f6f5)),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
