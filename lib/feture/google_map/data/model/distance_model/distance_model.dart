import 'row.dart';

class DistanceModel {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Row>? rows;
  String? status;

  DistanceModel({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,
  });

  factory DistanceModel.fromJson(Map<String, dynamic> json) => DistanceModel(
        destinationAddresses: json['destination_addresses'] as List<String>?,
        originAddresses: json['origin_addresses'] as List<String>?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => Row.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'destination_addresses': destinationAddresses,
        'origin_addresses': originAddresses,
        'rows': rows?.map((e) => e.toJson()).toList(),
        'status': status,
      };
}
