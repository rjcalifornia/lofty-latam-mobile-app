import 'package:flutter/material.dart';
import 'package:home_management_app/global.dart';

class DatePickerField extends StatelessWidget {
  final DateTime selectedPickerDate;
  final TextEditingController textController;
  final String labelText;
  final dynamic dateFieldChange;
  const DatePickerField(
      {super.key,
      required this.selectedPickerDate,
      required this.textController,
      required this.labelText,
      required this.dateFieldChange});

  @override
  Widget build(BuildContext context) {
    Future<void> datePicker(BuildContext context) async {
      // ignore: unused_local_variable
      final DateTime? picked = await showDatePicker(
          context: context,
          locale: const Locale("es", "ES"),
          initialDate: selectedPickerDate,
          firstDate: DateTime(2021, 8),
          lastDate: DateTime(2030),
          builder: (BuildContext context, Widget? child) {
            return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: BrandColors.rausch,
                    secondary: BrandColors.arches,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!);
          });

      textController.text = picked!.toIso8601String().split('T')[0];
      dateFieldChange(picked.toIso8601String().split('T')[0]);
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: GestureDetector(
        onTap: () => datePicker(context),
        child: AbsorbPointer(
          child: TextField(
            style: const TextStyle(
              color: Color(0xff313945),
            ),
            controller: textController,
            decoration: InputDecoration(
                labelText: labelText.toString(),
                prefixIcon: const Icon(Icons.calendar_today)),
          ),
        ),
      ),
    );
  }
}
