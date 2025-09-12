// ignore_for_file: file_names
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final dynamic changeStream;
  final String fieldHintText;
  const FormTextField(
      {super.key, required this.changeStream, required this.fieldHintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.name,
        onChanged: changeStream,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfff6f6f6),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          hintText: fieldHintText,
        ));
  }
}
