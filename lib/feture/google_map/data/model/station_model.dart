class StationModel {
  final double latitude;
  final double longitude;
  final String name;

  StationModel(
      {required this.latitude, required this.longitude, required this.name});
  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
