class PaymentInputIntantModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentInputIntantModel({
    required this.customerId,
    required String amount,
    required this.currency,
  }) : amount = amount.asAmount;

  toJson() {
    return {'amount': amount, 'currency': currency, 'customer': customerId};
  }
}

extension amauntPrice on String {
  String get asAmount {
    String parsedValue = (double.parse(this) * 100).toString();
    if (parsedValue == null) {
      throw FormatException('Invalid amount format');
    }
    var value = parsedValue.split(RegExp(r'\.'));
    return ((value[0]));
  }
}
