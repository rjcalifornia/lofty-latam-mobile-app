import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Property.dart';

class CreateLeaseScreen extends StatefulWidget {
  final Property? property;
  const CreateLeaseScreen({super.key, required this.property});

  @override
  State<CreateLeaseScreen> createState() => _CreateLeaseScreenState();
}

class _CreateLeaseScreenState extends State<CreateLeaseScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: BrandColors.rausch,
              elevation: 0,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 18, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Nuevo contrato para ${widget.property!.name}",
                          style: const TextStyle(
                              color: BrandColors.hof, fontSize: 20),
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),
                      // const Text(
                      //   "Mes a cancelar",
                      //   style: TextStyle(color: BrandColors.hof),
                      // ),
                      // StreamBuilder(
                      //     stream: _paymentsBloc.monthCancelledStream,
                      //     builder: (context, AsyncSnapshot snapshot) {
                      //       return Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           color: const Color(0xfff6f6f6),
                      //         ),
                      //         child: DropdownButtonFormField(
                      //           decoration: const InputDecoration(
                      //             enabledBorder: InputBorder.none,
                      //             disabledBorder: InputBorder.none,
                      //             focusedBorder: InputBorder.none,
                      //           ),
                      //           icon: const Icon(Icons.arrow_drop_down),
                      //           iconSize: 24,
                      //           elevation: 16,
                      //           style: const TextStyle(color: Colors.black),
                      //           isExpanded: true,
                      //           hint: const Center(
                      //               child: Text("Seleccione el mes a cancelar")),
                      //           items: monthsList.map((item) {
                      //             //print(item['id']);
                      //             return DropdownMenuItem(
                      //               value: item['id'].toString(),
                      //               child: Center(
                      //                 child: Text(item['label']),
                      //               ),
                      //             );
                      //           }).toList(),
                      //           onChanged: (value) {
                      //             _paymentsBloc
                      //                 .changeMonthCancelled(value.toString());
                      //             setState(() {
                      //               selectedMonth = value.toString();
                      //               // print(selectedMonth);
                      //               //print(selectedMonth);
                      //               //print(bloc.getMonthCancelled);
                      //             });
                      //           },
                      //           value: selectedMonth,
                      //         ),
                      //       );
                      //     }),
                    ]))));
  }
}
