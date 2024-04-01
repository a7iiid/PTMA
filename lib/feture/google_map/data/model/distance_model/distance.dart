import 'dart:convert';

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  factory Distance.fromMap(Map<String, dynamic> data) => Distance(
        text: data['text'] as String?,
        value: data['value'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'text': text,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Distance].
  factory Distance.fromJson(String data) {
    return Distance.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Distance] to a JSON string.
  String toJson() => json.encode(toMap());
}
