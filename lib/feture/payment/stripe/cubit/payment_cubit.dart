import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

import 'package:meta/meta.dart';
import 'package:ptma/core/utils/StripeSeirves.dart';
import 'package:ptma/feture/payment/stripe/model/qr_code_model.dart';

import '../../../../core/utils/cach/cach_helpar.dart';
import '../data/models/payment_input_intint_model.dart';
import '../data/repo/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.checkoutRepo}) : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);
  final CheckoutRepo checkoutRepo;

  int selectindex = 0;
  String? customerId;
  StripeSeirves stripeSeirves = StripeSeirves();

  Future<String> getCusomerId() async {
    customerId = CachHelper.getData('customerId');
    if (customerId == null || customerId!.isEmpty) {
      customerId = await StripeSeirves().createCustomerIntint();
      CachHelper.putData('customerId', customerId!);
    }
    return customerId!;
  }

  Future makePayment(
      {required PaymentInputIntantModel paymentInputIntantModel}) async {
    emit(PaymentLoding());
    var data = await checkoutRepo.makePayment(
        paymentInputIntantModel: paymentInputIntantModel);

    data.fold(
        (failuer) => emit(PaymentFailuer(messageError: failuer.messageError)),
        (success) => emit(PaymentSuccess()));
  }

  changeSelect(int index) {
    emit(ChangePaymentMethod());
    selectindex = index;
  }

  QrCodeModel scanQRData(String data) {
    emit(ScanneQRCodeInit());
    try {
      List<String> barcodeScanRes = data.split(',');

      if (barcodeScanRes.length == 2) {
        emit(ScanQRSuccess());
        return QrCodeModel(
            prise: barcodeScanRes[0],
            trip: barcodeScanRes[1],
            dateTime: DateTime.now());
      }
      emit(ScanQRFailuer());
      return QrCodeModel(prise: '0', trip: '0', dateTime: DateTime.now());
    } catch (e) {
      emit(ScanQRFailuer());
      return QrCodeModel(prise: '0', trip: '0', dateTime: DateTime.now());
    }
  }
}
