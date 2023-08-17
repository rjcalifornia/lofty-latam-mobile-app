import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneRegistrationPage extends StatelessWidget {
  final UserBloc userBloc;
  final PageController controller;
  const PhoneRegistrationPage(
      {super.key, required this.userBloc, required this.controller});

  @override
  Widget build(BuildContext context) {
    dynamic phoneFormatter = MaskTextInputFormatter(
        mask: '####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, bottom: 18, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Registra una cuenta en Lofty",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: BrandColors.loft, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 28,
          ),
          const Text(
            "¡Iniciemos!",
            style: TextStyle(
                color: BrandColors.foggy,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 22,
          ),
          const Text(
            "Número de teléfono",
            style: TextStyle(color: BrandColors.loft),
          ),
          StreamBuilder(
              stream: userBloc.phoneStream,
              builder: (context, AsyncSnapshot snapshot) {
                return TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [phoneFormatter],
                    onChanged: userBloc.changePhone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "Ingrese su número de teléfono celular",
                    ));
              }),
          const SizedBox(
            height: 18,
          ),
          const Text(
            "No compartiremos su número telefónico con ninguna persona o empresa",
            style: TextStyle(fontSize: 10, color: BrandColors.hof),
          ),
          const SizedBox(
            height: 18,
          ),
          StreamBuilder(
            stream: userBloc.verifyPhone,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                // ignore: avoid_unnecessary_containers
                return Container(
                  child: const Column(
                    children: [
                      Center(
                        child: Text(
                          "Complete todos los datos requeridos",
                          style: TextStyle(color: BrandColors.foggy),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BrandColors.arches,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Siguiente", style: TextStyle(fontSize: 22)),
                    ],
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
