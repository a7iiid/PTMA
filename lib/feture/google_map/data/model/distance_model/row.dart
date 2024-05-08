import 'element.dart';

class Row {
  List<Element>? elements;

  Row({this.elements});

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        elements: (json['elements'] as List<dynamic>?)
            ?.map((e) => Element.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'elements': elements?.map((e) => e.toJson()).toList(),
      };
}
