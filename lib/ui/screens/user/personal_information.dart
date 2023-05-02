import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView();
        } else {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xffff385c), size: 28),
          );
        }
      })),
    );
  }
}
