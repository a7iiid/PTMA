import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';
import '../models/payment_input_intint_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentInputIntantModel paymentInputIntantModel});
}
