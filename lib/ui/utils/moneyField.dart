// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MoneyField extends StatelessWidget {
  final dynamic changeStream;
  final dynamic snapshot;
  final String labelText;
  const MoneyField(
      {super.key,
      required this.changeStream,
      required this.snapshot,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: changeStream,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfff6f6f6),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          hintText: labelText,
          //labelText: 'Escriba la cantidad recibida',
          errorText: snapshot.hasError ? snapshot.error.toString() : null),
    );
  }
}
