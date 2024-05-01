import 'package:flutter/material.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

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
          return 'pleas Enter name'.tr(context);
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Full name".tr(context),
          label: Text("Full name".tr(context)),
          enabledBorder: UnderlineInputBorder()),
    );
  }
}
