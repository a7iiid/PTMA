import 'package:flutter/material.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/history/presantation/view/history_body.dart';

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue[50],
              title: Text('Trip History'.tr(context)),
            ),
            drawer: CustomeDrawer(),
            body: HistoryBody()));
  }
}
