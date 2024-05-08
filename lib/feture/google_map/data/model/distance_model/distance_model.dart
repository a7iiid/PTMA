class DistanceModel {
  String? distanceText;
  int? distanceValue;
  String? durationText;
  int? durationValue;

  DistanceModel({
    this.distanceText,
    this.distanceValue,
    this.durationText,
    this.durationValue,
  });

  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    return DistanceModel(
      distanceText: json['rows'][0]['elements'][0]['distance']['text'],
      distanceValue: json['rows'][0]['elements'][0]['distance']['value'],
      durationText: json['rows'][0]['elements'][0]['duration']['text'],
      durationValue: json['rows'][0]['elements'][0]['duration']['value'],
    );
  }
}
