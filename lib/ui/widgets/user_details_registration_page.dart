import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/utils/formTextField.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserDetailsRegistrationPage extends StatelessWidget {
  final UserBloc userBloc;
  const UserDetailsRegistrationPage({super.key, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    dynamic duiFormatter = MaskTextInputFormatter(
        mask: '########-#',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, bottom: 18, left: 32, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Agrega tu información",
            style: TextStyle(
                color: BrandColors.foggy,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 22,
          ),
          const Row(
            children: [
              Icon(
                Icons.person_outlined,
                color: BrandColors.hof,
                size: 14,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Nombres",
                style: TextStyle(color: BrandColors.hof),
              ),
            ],
          ),
          StreamBuilder(
              stream: userBloc.nameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: userBloc.changeName,
                    fieldHintText: 'Ingrese sus nombres');
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.person_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Apellidos",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: userBloc.lastnameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: userBloc.changeLastname,
                    fieldHintText: 'Ingrese sus apellidos');
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.location_city_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Departamento",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.badge_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Número de DUI",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: userBloc.documentStream,
              builder: (context, AsyncSnapshot snapshot) {
                return TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [duiFormatter],
                    onChanged: userBloc.changeDocument,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "Ingrese su número de DUI",
                    ));
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.supervised_user_circle_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Usuario",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: userBloc.usernameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: userBloc.changeUsername,
                    fieldHintText: 'Ingrese su nombre de usuario');
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.email_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Correo electrónico",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: userBloc.emailStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: userBloc.changeEmail,
                    fieldHintText: 'Correo electrónico es opcional');
              }),
          const SizedBox(
            height: 22,
          ),
          const Text(
            "Contraseña",
            style: TextStyle(color: BrandColors.hof),
          ),
          StreamBuilder(
              stream: userBloc.passwordStream,
              builder: (context, AsyncSnapshot snapshot) {
                return TextField(
                    obscureText: true,
                    onChanged: userBloc.changePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff6f6f6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "Escriba una contraseña",
                    ));
              }),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(fontSize: 10, color: BrandColors.hof),
                  children: <TextSpan>[
                const TextSpan(text: 'Al seleccionar Aceptar y Continuar, '),
                TextSpan(
                    text: 'acepta todos los términos y condiciones',
                    style: const TextStyle(
                        fontSize: 10,
                        color: BrandColors.hof,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
                const TextSpan(
                    text: ' de Lofty Latam.',
                    style: TextStyle(fontSize: 10, color: BrandColors.hof))
              ])),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: userBloc.verifyRegistrationData,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      userBloc.createNewUser(context);
                      //_paymentsBloc.generateReceipt(context, widget.lease.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BrandColors.fty,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Aceptar y continuar",
                            style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
