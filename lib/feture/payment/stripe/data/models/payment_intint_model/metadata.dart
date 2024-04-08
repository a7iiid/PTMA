class Metadata {
  final Map<String, dynamic>? metadata;

  Metadata({
    this.metadata,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      metadata: json['metadata'] == null
          ? null
          : Map<String, dynamic>.from(json['metadata'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
