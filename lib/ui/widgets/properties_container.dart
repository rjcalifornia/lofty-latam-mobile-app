import 'package:flutter/material.dart';

class PropertiesContainer extends StatelessWidget {
  final int id;
  const PropertiesContainer({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Name of property',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .apply(color: const Color(0xff313539), fontWeightDelta: 2),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: const <Widget>[Text("Descripción de la propiedad")],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                  side: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              child: const Text("Detalles"),
            ),
            const SizedBox(width: 15.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
              child: const Text(
                "Historial de pagos",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const Divider(
          height: 21,
          color: Colors.blueGrey,
        ),
      ],
    );
  }
}
