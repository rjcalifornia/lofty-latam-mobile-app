import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class CreatePropertyScreen extends StatefulWidget {
  const CreatePropertyScreen({super.key});

  @override
  State<CreatePropertyScreen> createState() => _CreatePropertyScreenState();
}

class _CreatePropertyScreenState extends State<CreatePropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: BrandColors.hof),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ));
  }
}
