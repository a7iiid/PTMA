import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/utils/rout.dart';
import 'package:ptma/feture/settings/view/widget/customDropDown.dart';

import '../../../../core/manger/cubit/loclaization_cubit.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});
  @override
  Widget build(BuildContext context) {
    String langValue =
        LoclaizationCubit.get(context).isArabic ? "Arabic" : "English";

    List<DropdownMenuItem<String>> menu = [
      DropdownMenuItem(value: "Arabic", child: Text("Arabic".tr(context))),
      DropdownMenuItem(value: "English", child: Text("English".tr(context))),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Column(
        children: [
          ListTile(
            title: Text("Language".tr(context)),
            trailing: customDropDownButton(context, menu, langValue),
          ),
          const Divider(),
          ListTile(
            title: Text("Account".tr(context)),
            trailing: Transform.rotate(
                angle: pi, child: Icon(Icons.arrow_back_ios_new)),
            onTap: () {
              GoRouter.of(context).push(Routes.kEditProfilePage);
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
