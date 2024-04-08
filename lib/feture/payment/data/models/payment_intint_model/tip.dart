class Tip {
  final String? id;
  final String? object;
  final int? amount;

  Tip({
    this.id,
    this.object,
    this.amount,
  });
  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id'] as String?,
      object: json['object'] as String?,
      amount: json['amount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
