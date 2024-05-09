import 'dart:developer';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';
import 'package:ptma/feture/history/data/model/history_service.dart';
import 'package:ptma/feture/payment/stripe/model/qr_code_model.dart';

import '../../../core/utils/images.dart';
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
  QrCodeModel qrCodeModel = QrCodeModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => PaymentCubit(checkoutRepo: checkoutRepoImpl()),
          child: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Success'.tr(context))));
              }
              if (state is PaymentFailuer) {
                log(state.messageError);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Unsuccess".tr(context))));
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
                          height: 50,
                        ),
                        PymantSelected()
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .12,
                  ),
                ),
                SliverToBoxAdapter(
                    child: BlocConsumer<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    if (state is ScanQRFailuer) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Confirm Qr Code ".tr(context))));
                    }
                  },
                  builder: (context, state) {
                    return state is ScanQRSuccess
                        ? Container(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xff34A853),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(Assets.imagesSuccess),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 300,
                            width: double.infinity,
                            child: AiBarcodeScanner(
                              canPop: false,
                              fit: BoxFit.fitWidth,
                              controller: MobileScannerController(
                                detectionSpeed: DetectionSpeed.noDuplicates,
                              ),
                              onScan: (String value) {
                                qrCodeModel =
                                    PaymentCubit.get(context).scanQRData(value);
                              },

                              bottomBar:
                                  null, // Set this to null to hide the bottom bar
                              appBar: null,
                            ),
                          );
                  },
                )),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: customBottom(
                        isEnabled: state is ScanQRSuccess,
                        title: "Payment".tr(context),
                        formKey: formKey,
                        onTap: () async {
                          if (BlocProvider.of<PaymentCubit>(context)
                                  .selectindex ==
                              0) {
                            await BlocProvider.of<PaymentCubit>(context)
                                .makePayment(
                              paymentInputIntantModel: PaymentInputIntantModel(
                                amount: qrCodeModel.prise!,
                                currency: 'USD',
                                customerId:
                                    await BlocProvider.of<PaymentCubit>(context)
                                        .getCusomerId(),
                              ),
                            );
                            final now = new DateTime.now();
                            String formatter = DateFormat('yMd').format(now);
                            HistoryModel historyModel = HistoryModel(
                                tripNam: qrCodeModel.trip!,
                                price: qrCodeModel.prise!,
                                dateTrip: formatter);
                            HistoryService.get().addItem(historyModel);
                            qrCodeModel = QrCodeModel();
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
