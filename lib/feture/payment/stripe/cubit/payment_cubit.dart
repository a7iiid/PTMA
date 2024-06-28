import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

import 'package:meta/meta.dart';
import 'package:ptma/core/utils/StripeSeirves.dart';
import 'package:ptma/feture/payment/stripe/model/BusTrip.dart';

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

  BusTrip scanQRData(String data) {
    emit(ScanneQRCodeInit());
    try {
      var barcodeScanRes = data.split(',');

      if (barcodeScanRes.length == 5) {
        emit(ScanQRSuccess());
        return BusTrip.fromQrCode(data);
      }
      emit(ScanQRFailuer());
      return BusTrip(
          prise: '0',
          busnum: 0,
          from: "0",
          to: "0",
          tripid: "0",
          dateTime: DateTime.now());
    } catch (e) {
      emit(ScanQRFailuer());
      return BusTrip(
          prise: '0',
          busnum: 0,
          from: "0",
          to: "0",
          tripid: "0",
          dateTime: DateTime.now());
    }
  }
}
