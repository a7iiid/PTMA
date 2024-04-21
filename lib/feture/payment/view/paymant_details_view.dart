import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ptma/feture/payment/stripe/model/qr_code_model.dart';

import '../stripe/data/models/payment_input_intint_model.dart';
import '../stripe/data/repo/checkout_repo_implemantation.dart';
import '../stripe/cubit/payment_cubit.dart';
import 'thank_you_view.dart';
import 'widget/custom_bottom.dart';
import 'widget/paymant details/paymantSelected.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  GlobalKey<FormState> formKey = GlobalKey();
  late QrCodeModel qrCodeModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => PaymentCubit(checkoutRepo: checkoutRepoImpl()),
          child: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Success')));
              }
              if (state is PaymentFailuer) {
                log(state.messageError);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.messageError)));
              }
            },
            builder: (context, state) => CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        PymantSelected()
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ElevatedButton(
                      onPressed: () async => qrCodeModel =
                          await BlocProvider.of<PaymentCubit>(context).scanQR(),
                      child: Text('Start QR scan')),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: customBottom(
                        title: "Payment",
                        formKey: formKey,
                        onTap: () async {
                          if (BlocProvider.of<PaymentCubit>(context)
                                  .selectindex ==
                              0) {
                            BlocProvider.of<PaymentCubit>(context).makePayment(
                              paymentInputIntantModel: PaymentInputIntantModel(
                                amount: qrCodeModel.prise,
                                currency: 'USD',
                                customerId:
                                    await BlocProvider.of<PaymentCubit>(context)
                                        .getCusomerId(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
