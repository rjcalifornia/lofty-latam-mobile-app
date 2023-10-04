import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BrandColors {
  static const rausch = Color(0xffFF5A5F),
      babu = Color(0xff00A699),
      arches = Color(0xffFC642D),
      hof = Color(0xff484848),
      foggy = Color(0xff767676),
      loft = Color(0xff2e2d2d),
      fty = Color(0xffff405c);
}

class CustomDialogs {
  static loadingDialog(context, loadingText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: BrandColors.arches, size: 38),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      loadingText.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BrandColors.foggy),
                    )
                  ],
                ),
              ));
        });
  }

  static fatalErrorDialog(context, message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Atención"),
            content: Text(message.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Aceptar"))
            ],
          );
        });
  }

  static navigationLoader(message) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.inkDrop(
                color: const Color(0xffff385c), size: 28),
            const SizedBox(
              height: 12,
            ),
            Text(
              message.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: BrandColors.foggy),
            )
          ]),
    );
  }

  static infoDialog(context, dialogTitle, dialogMessage) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(dialogTitle.toString()),
            content: Text(dialogMessage.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                  },
                  child: const Text("Aceptar"))
            ],
          );
        });
  }
}
