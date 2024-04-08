import 'package:dartz/dartz.dart';
import 'package:ptma/feture/payment/stripe/data/repo/checkout_repo.dart';

import '../../../../../core/utils/StripeSeirves.dart';
import '../../../../../core/utils/failure.dart';
import '../models/payment_input_intint_model.dart';

class checkoutRepoImpl extends CheckoutRepo {
  final StripeSeirves stripeSeirves = StripeSeirves();

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentInputIntantModel paymentInputIntantModel}) async {
    try {
      await stripeSeirves.makePayment(
          paymentInputIntantModel: paymentInputIntantModel);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure(messageError: e.toString()));
    }
  }
}
