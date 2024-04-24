import 'package:flutter/material.dart';

class UserNameInput extends StatelessWidget {
  const UserNameInput({
    super.key,
    required this.nameControlar,
  });

  final TextEditingController nameControlar;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameControlar,
      validator: (value) {
        if (value!.isEmpty) {
          return 'pleas Enter name';
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'Full name',
          label: Text('Full name'),
          enabledBorder: UnderlineInputBorder()),
    );
  }
}
