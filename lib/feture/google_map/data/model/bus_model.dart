class BusModel {
  final double buslatitude;
  final double buslongitude;
  final double startlatitude;
  final double startlongitude;

  final double endlatitude;

  final double endlongitude;

  final String busname;

  final String busnumber;
  final bool isActive;

  BusModel({
    required this.startlatitude,
    required this.startlongitude,
    required this.endlatitude,
    required this.endlongitude,
    required this.busname,
    required this.busnumber,
    required this.isActive,
    required this.buslatitude,
    required this.buslongitude,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
        busname: json['busname'],
        busnumber: json['busnumber'],
        endlatitude: json['endlatitude'].toDouble(),
        endlongitude: json['endlongitude'].toDouble(),
        startlatitude: json['startlatitude'].toDouble(),
        startlongitude: json['startlongitude'].toDouble(),
        isActive: json['isActive'],
        buslatitude: json['buslatitude'].toDouble(),
        buslongitude: json['buslongitude'].toDouble());
  }
}