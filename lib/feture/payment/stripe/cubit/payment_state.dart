part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoding extends PaymentState {}

final class PaymentFailuer extends PaymentState {
  final String messageError;

  PaymentFailuer({required this.messageError});
}

final class PaymentSuccess extends PaymentState {}

final class ChangePaymentMethod extends PaymentState {}

final class ScanneQRCodeInit extends PaymentState {}

final class ScanQRLoding extends PaymentState {}

final class ScanQRFailuer extends PaymentState {}

final class ScanQRSuccess extends PaymentState {}
