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
