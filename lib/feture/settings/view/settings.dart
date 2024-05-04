import 'package:flutter/material.dart';
import 'package:ptma/feture/settings/view/widget/settings_body.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SettingsBody(),
    ));
  }
}
