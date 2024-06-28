class BusTrip {
  String? prise;
  String? from;
  String? to;
  int? busnum;
  String? tripid;
  DateTime? dateTime;

  BusTrip({
    this.prise,
    this.from,
    this.to,
    this.busnum,
    this.tripid,
    this.dateTime,
  });

  factory BusTrip.fromQrCode(String qrCodeData) {
    // Split the data using commas as the delimiter
    final data = qrCodeData.split(', ');
    // Create a map to hold the key-value pairs
    final Map<String, String> dataMap = {};

    // Iterate over each item in the split data
    for (var item in data) {
      // Split each item into key and value
      final keyValue = item.split(': ');
      if (keyValue.length == 2) {
        dataMap[keyValue[0]] = keyValue[1];
      }
    }

    // Return a new BusTrip instance with parsed values
    return BusTrip(
      prise: dataMap['salary'] ?? '0.0',
      from: dataMap['from'] ?? '',
      to: dataMap['to'] ?? '',
      busnum: int.parse(dataMap['busnum'] ?? '0'),
      tripid: dataMap['tripid'] ?? '0',
      dateTime: DateTime.now(),
    );
  }

  // Optionally, you can add a method to convert the BusTrip instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'salary': prise,
      'from': from,
      'to': to,
      'busnum': busnum,
      'tripid': tripid,
    };
  }
}
