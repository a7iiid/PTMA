class PaymentInputIntantModel {
  final String amount;
  final String currency;

  PaymentInputIntantModel({required this.amount, required this.currency});

  toJson() {
    return {'amount': amount, 'currency': currency};
  }
}
