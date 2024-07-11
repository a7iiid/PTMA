
import 'package:flutter/material.dart';
import 'package:ptma/feture/history/presantation/view/history_body.dart';

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
            ),
            body: HistoryBody()));
  }
}
