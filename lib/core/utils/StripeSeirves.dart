import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ptma/core/utils/apiKey.dart';

import '../../feture/payment/stripe/data/models/payment_input_intint_model.dart';
import '../../feture/payment/stripe/data/models/payment_intint_model/payment_intint_model.dart';
import 'ApiServes/payment_api.dart';

class StripeSeirves {
  final PaymentApiService apiSeirves = PaymentApiService();
  Future<PaymentIntintModel> createPaymentIntint(
      PaymentInputIntantModel paymentInputIntantModel) async {
    var response = await apiSeirves.post(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentInputIntantModel.toJson(),
      token: ApiKey.secretKeyStripe,
      contentType: Headers.formUrlEncodedContentType,
    );
    var paymentInintModel = PaymentIntintModel.fromJson(response.data);
    return paymentInintModel;
  }

//TODO:
  Future<PaymentIntintModel> createCustomerIntint(
      PaymentInputIntantModel paymentInputIntantModel) async {
    var response = await apiSeirves.post(
      url: 'https://api.stripe.com/v1/customers',
      body: paymentInputIntantModel.toJson(),
      token: ApiKey.secretKeyStripe,
      contentType: Headers.formUrlEncodedContentType,
    );
    var paymentInintModel = PaymentIntintModel.fromJson(response.data);
    return paymentInintModel;
  }

  Future initPaymentSheet({required String paymentIntintClintSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntintClintSecret,
        merchantDisplayName: "PTMA",
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentInputIntantModel paymentInputIntantModel}) async {
    var paymentIntintModel = await createPaymentIntint(paymentInputIntantModel);

    await initPaymentSheet(
        paymentIntintClintSecret: paymentIntintModel.clientSecret!);
    await displayPaymentSheet();
  }
}
