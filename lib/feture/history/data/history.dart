class History {
  final String tripNam;

  final int price;

  final String dateTrip;
  final int bus_num;
  DateTime? dateTime;

  History(
      {required this.tripNam,
      required this.bus_num,
      required this.price,
      required this.dateTrip,
      this.dateTime});
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      tripNam: json['from'] + '-' + json['to'],
      price: json['price'],
      dateTrip: json['dateTrip'],
      bus_num: json['bus_num'],
    );
  }
}
