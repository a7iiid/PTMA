import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ptma/core/utils/apiKey.dart';
import 'package:ptma/feture/payment/stripe/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:ptma/feture/payment/stripe/data/models/init_payment_sheet_input_model.dart';

import '../../feture/payment/stripe/data/models/customer_intint_model/customer_intint_model.dart';
import '../../feture/payment/stripe/data/models/payment_input_intint_model.dart';
import '../../feture/payment/stripe/data/models/payment_intint_model/payment_intint_model.dart';
import 'ApiServes/payment_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<EphemeralKeyModel> createEphemeralKey({String? customerId}) async {
    var response = await apiSeirves.post(
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        body: {
          'customer': customerId,
        },
        token: ApiKey.secretKeyStripe,
        contentType: Headers.formUrlEncodedContentType,
        header: {
          'Authorization': 'Bearer ${ApiKey.secretKeyStripe}',
          'Stripe-Version': '2023-08-16'
        });
    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }

  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            initPaymentSheetInputModel.paymentIntentClintSecretKey,
        customerEphemeralKeySecret:
            initPaymentSheetInputModel.ephemralSecretKey,
        customerId: initPaymentSheetInputModel.customerId,
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
    var ephemeralKeyModel = await createEphemeralKey(
        customerId: paymentInputIntantModel.customerId);

    var initPaymentSheetInpotModel = InitPaymentSheetInputModel(
      paymentIntentClintSecretKey: paymentIntintModel.clientSecret!,
      customerId: paymentInputIntantModel.customerId,
      ephemralSecretKey: ephemeralKeyModel.secret!,
    );
    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInpotModel);
    await displayPaymentSheet();
  }

  Future<String> createCustomerIntint() async {
    var response = await apiSeirves.post(
      url: 'https://api.stripe.com/v1/customers',
      body: {
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'email': FirebaseAuth.instance.currentUser!.email
      },
      token: ApiKey.secretKeyStripe,
      contentType: Headers.formUrlEncodedContentType,
    );
    var customerIntintModel = CustomerIntintModel.fromJson(response.data);
    return customerIntintModel.id!;
  }
}
