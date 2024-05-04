class BusModel {
  final double startlatitude;
  final double startlongitude;

  final double endlatitude;

  final double endlongitude;

  final String busname;

  final String busnumber;

  BusModel(
      {required this.startlatitude,
      required this.startlongitude,
      required this.endlatitude,
      required this.endlongitude,
      required this.busname,
      required this.busnumber});
}
