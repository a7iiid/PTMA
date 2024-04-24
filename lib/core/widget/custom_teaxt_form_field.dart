import 'package:flutter/material.dart';

class CustomTeaxtFormField extends StatelessWidget {
  const CustomTeaxtFormField({
    super.key,
    required this.controlar,
    required this.hintText,
    required this.labelText,
    required this.validatText,
    this.keyboardType,
  });

  final TextEditingController controlar;
  final TextInputType? keyboardType;
  final String hintText;
  final String labelText;
  final String validatText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlar,
      validator: (value) {
        if (value!.isEmpty) {
          return validatText;
        }
        return null;
      },
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
          hintText: hintText,
          label: Text(labelText),
          enabledBorder: UnderlineInputBorder()),
    );
  }
}
