import 'package:flutter/material.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';

Widget buildDialog(BuildContext context) {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();

  return AlertDialog(
    title: Text("Confirm password ".tr(context)),
    content: Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("pleas Enter Passwored".tr(context)),
          TextFormField(
            controller: passController,
            validator: (value) {
              if (value!.isEmpty) {
                return "pleas Enter Passwored".tr(context);
              }
              return null;
            },
          )
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text('OK'),
        onPressed: () async {
          if (key.currentState!.validate()) {
            await AppCubit.get(context).confirmConiction(passController.text);
            Navigator.of(context).pop();
          }
        },
      ),
    ],
  );
}
