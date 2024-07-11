import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String tripNam;
  final double price;
  final String dateTrip;
  final int bus_num;
  DateTime? dateTime;

  History({
    required this.tripNam,
    required this.bus_num,
    required this.price,
    required this.dateTrip,
    this.dateTime,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['time_date'] as Timestamp;
    return History(
      tripNam: json['from'] + '-' + json['to'],
      price: (json['salary'] as num).toDouble(),
      dateTrip: timestamp.toDate().toString(), // Convert Timestamp to String
      bus_num: json['bus_num'],
      dateTime: timestamp.toDate(), // Store the DateTime as well
    );
  }
}
