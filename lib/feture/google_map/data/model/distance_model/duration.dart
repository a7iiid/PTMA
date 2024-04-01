import 'dart:convert';

class Duration {
  String? text;
  int? value;

  Duration({this.text, this.value});

  factory Duration.fromMap(Map<String, dynamic> data) => Duration(
        text: data['text'] as String?,
        value: data['value'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'text': text,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Duration].
  factory Duration.fromJson(String data) {
    return Duration.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Duration] to a JSON string.
  String toJson() => json.encode(toMap());
}
