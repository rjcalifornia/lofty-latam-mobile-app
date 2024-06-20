import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Departamentos.dart';
import 'package:home_management_app/models/Distritos.dart';
import 'package:home_management_app/models/Municipios.dart';
import 'package:home_management_app/ui/utils/formTextField.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRegistrationPage extends StatefulWidget {
  final UserBloc userBloc;
  const UserRegistrationPage({super.key, required this.userBloc});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  //final UserBloc userBloc = UserBloc();
  List<Departamentos> departamentosList = [];
  List<Municipios> municipiosList = [];
  List<Distritos> distritosList = [];

  Future getDepartamentosData() async {
    final departamentosJson = await widget.userBloc.getDepartamentos();

    setState(() {
      departamentosList = departamentosJson;
    });
  }

  Future getMunicipiosData(departamentoId) async {
    final municipiosJson = await widget.userBloc.getMunicipios(departamentoId);

    setState(() {
      municipiosList = municipiosJson;
    });
  }

  Future getDistritosData(municipioId) async {
    final distritosJson = await widget.userBloc.getDistritos(municipioId);

    setState(() {
      distritosList = distritosJson;
    });
  }

  @override
  void initState() {
    getDepartamentosData();
    super.initState();
  }

  Widget build(BuildContext context) {
    String? departamentoSelected;
    String? municipioSelected;
    String? distritoSelected;

    final Uri url = Uri.parse('https://loftylatam.com/terminos-de-servicio/');
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
              stream: widget.userBloc.nameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: widget.userBloc.changeName,
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
              stream: widget.userBloc.lastnameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: widget.userBloc.changeLastname,
                    fieldHintText: 'Ingrese sus apellidos');
              }),
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
              stream: widget.userBloc.documentStream,
              builder: (context, AsyncSnapshot snapshot) {
                return TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [duiFormatter],
                    onChanged: widget.userBloc.changeDocument,
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
              Icons.location_on_outlined,
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
          StreamBuilder(
              stream: widget.userBloc.departamentoStream,
              builder: (context, AsyncSnapshot snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff6f6f6),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                    hint: const Center(child: Text("Seleccione departamento")),
                    items: departamentosList.map((item) {
                      return DropdownMenuItem(
                        value: item.id.toString(),
                        child: Center(
                          child: Text(item.nombre.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        departamentoSelected = value.toString();
                      });
                      getMunicipiosData(departamentoSelected);
                    },
                    value: departamentoSelected,
                  ),
                );
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.location_on_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Municipio",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: widget.userBloc.municipioStream,
              builder: (context, AsyncSnapshot snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff6f6f6),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                    hint: const Center(child: Text("Seleccione municipio")),
                    items: municipiosList.map((item) {
                      return DropdownMenuItem(
                        value: item.id.toString(),
                        child: Center(
                          child: Text(item.nombre.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        municipioSelected = value.toString();
                      });
                      getDistritosData(municipioSelected);
                    },
                    value: municipioSelected,
                  ),
                );
              }),
          const SizedBox(
            height: 22,
          ),
          const Row(children: [
            Icon(
              Icons.location_on_outlined,
              color: BrandColors.hof,
              size: 14,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Distrito",
              style: TextStyle(color: BrandColors.hof),
            ),
          ]),
          StreamBuilder(
              stream: widget.userBloc.distritoStream,
              builder: (context, AsyncSnapshot snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff6f6f6),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                    hint: const Center(child: Text("Seleccione un distrito")),
                    items: distritosList.map((item) {
                      return DropdownMenuItem(
                        value: item.id.toString(),
                        child: Center(
                          child: Text(item.nombre.toString()),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      widget.userBloc.changeDistrito(value.toString());
                      print(value.toString());
                      setState(() {
                        distritoSelected = value.toString();
                      });
                    },
                    value: distritoSelected,
                  ),
                );
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
              stream: widget.userBloc.emailStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: widget.userBloc.changeEmail,
                    fieldHintText: 'Correo electrónico es opcional');
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
              stream: widget.userBloc.usernameStream,
              builder: (context, AsyncSnapshot snapshot) {
                return FormTextField(
                    changeStream: widget.userBloc.changeUsername,
                    fieldHintText: 'Ingrese su nombre de usuario');
              }),
          const SizedBox(
            height: 22,
          ),
          const Text(
            "Contraseña",
            style: TextStyle(color: BrandColors.hof),
          ),
          StreamBuilder(
              stream: widget.userBloc.passwordStream,
              builder: (context, AsyncSnapshot snapshot) {
                return TextField(
                    obscureText: true,
                    onChanged: widget.userBloc.changePassword,
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(url);
                        print('test');
                      }),
                const TextSpan(
                    text: ' de Lofty Latam.',
                    style: TextStyle(fontSize: 10, color: BrandColors.hof))
              ])),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: widget.userBloc.verifyRegistrationData,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      widget.userBloc.createNewUser(context);
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
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)),
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
