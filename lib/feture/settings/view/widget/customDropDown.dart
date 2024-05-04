import 'package:flutter/material.dart';

import '../../../../core/manger/cubit/loclaization_cubit.dart';

DropdownButton<String> customDropDownButton(BuildContext context,
    List<DropdownMenuItem<String>> menu, String langValue) {
  return DropdownButton(
    value: langValue,
    icon: const Icon(Icons.menu),
    onChanged: (value) {
      langValue = value.toString();
      if (value == "Arabic") {
        LoclaizationCubit.get(context).changeLang(true);
      } else if (value == "English") {
        LoclaizationCubit.get(context).changeLang(false);
      }
    },
    items: menu,
  );
}

bool changeSelect(String? lang) {
  if (lang == null) return false;
  if (lang == "Arabic") return true;
  return false;
}
