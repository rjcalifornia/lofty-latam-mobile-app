import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class CreatePropertyFancyHeader extends StatelessWidget {
  const CreatePropertyFancyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClip(),
      child: Container(
          padding: const EdgeInsets.all(25.0),
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                BrandColors.rausch,
                BrandColors.rausch,
              ],
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Crear una nueva propiedad",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class MyCustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 1.3);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
