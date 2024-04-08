class PaymentInputIntantModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentInputIntantModel(
      {required this.customerId, required this.amount, required this.currency});

  toJson() {
    return {
      'amount': amount.asAmount as String,
      'currency': currency,
      'customer': customerId
    };
  }
}

extension on String {
  String get asAmount {
    int? parsedValue = int.tryParse(this);
    if (parsedValue == null) {
      throw FormatException('Invalid amount format');
    }
    return (parsedValue * 100).toString();
  }
}
