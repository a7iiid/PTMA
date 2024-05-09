import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String tripNam;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String dateTrip;

  HistoryModel(
      {required this.tripNam, required this.price, required this.dateTrip});
}
