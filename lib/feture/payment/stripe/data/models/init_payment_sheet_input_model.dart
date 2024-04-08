class InitPaymentSheetInputModel {
  final String ephemralSecretKey;
  final String customerId;
  final String paymentIntentClintSecretKey;

  InitPaymentSheetInputModel(
      {required this.ephemralSecretKey,
      required this.customerId,
      required this.paymentIntentClintSecretKey});
}
