import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/StripeSeirves.dart';
import 'package:ptma/feture/payment/stripe/model/qr_code_model.dart';

import '../../../../core/utils/cach/cach_helpar.dart';
import '../data/models/payment_input_intint_model.dart';
import '../data/repo/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.checkoutRepo}) : super(PaymentInitial());
  static get(context) => BlocProvider.of<PaymentCubit>(context);
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

  Future<QrCodeModel> scanQR() async {
    emit(ScanneQRCodeInit());
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      emit(ScanQRLoding());
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      emit(ScanQRFailuer());
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    emit(ScanQRSuccess());
    List<String> detels = barcodeScanRes.split(',');
    return QrCodeModel(
        prise: detels[0], trip: detels[1], dateTime: DateTime.now());
  }
}
