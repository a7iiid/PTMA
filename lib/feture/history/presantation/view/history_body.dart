import 'package:flutter/material.dart';

import '../../data/model/history_model.dart';

class HistoryBody extends StatelessWidget {
  HistoryBody({super.key});
  List<HistoryModel> history = [
    HistoryModel(
        tripNam: "Qabatia-jenin", price: "5 ILS", dateTrip: DateTime.now()),
    HistoryModel(
        tripNam: "Qabatia-jenin", price: "5 ILS", dateTrip: DateTime.now()),
    HistoryModel(
        tripNam: "Qabatia-jenin", price: "5 ILS", dateTrip: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(history[index].tripNam),
              subtitle: Text(history[index].price),
              trailing: Text(history[index].dateTrip.toString()),
            );
          },
        )
      ],
    );
  }
}
