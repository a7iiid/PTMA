import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/payment_input_intint_model.dart';
import '../data/repo/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.checkoutRepo}) : super(PaymentInitial());
  static get(context) => BlocProvider.of<PaymentCubit>(context);
  final CheckoutRepo checkoutRepo;
  Future makePayment(
      {required PaymentInputIntantModel paymentInputIntantModel}) async {
    emit(PaymentLoding());
    var data = await checkoutRepo.makePayment(
        paymentInputIntantModel: paymentInputIntantModel);

    data.fold(
        (failuer) => emit(PaymentFailuer(messageError: failuer.messageError)),
        (success) => emit(PaymentSuccess()));
  }
}
