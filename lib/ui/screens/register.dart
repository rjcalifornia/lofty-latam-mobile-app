import 'package:flutter/material.dart';
import 'package:home_management_app/bloc/user_bloc.dart';
import 'package:home_management_app/ui/widgets/phone_registration_page.dart';
import 'package:home_management_app/ui/widgets/test.dart';
import 'package:home_management_app/ui/widgets/user_details_registration_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = UserBloc();
    final PageController controller = PageController();

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            //backgroundColor: const Color(0xfff5f5f5),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context)),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              },
              children: [
                PhoneRegistrationPage(
                  userBloc: userBloc,
                  controller: controller,
                ),
                UserRegistrationPage(),
              ],
            )));
  }
}
