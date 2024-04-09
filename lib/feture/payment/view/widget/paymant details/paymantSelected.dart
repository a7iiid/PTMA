import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/feture/payment/stripe/cubit/payment_cubit.dart';

import '../../../../../core/utils/images.dart';
import '../../../stripe/model/paymant_model.dart';
import '../../paymant_details_view.dart';
import 'pymant_item_selected.dart';

class PymantSelected extends StatelessWidget {
  const PymantSelected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<PaymantMethodModel> paymantList = [
      PaymantMethodModel(isActiv: true, image: Assets.imagesCard),
      PaymantMethodModel(isActiv: false, image: Assets.imagesPaypal),
      PaymantMethodModel(isActiv: false, image: Assets.imagesApplePay),
    ];

    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: paymantList.asMap().entries.map((e) {
            return Expanded(
                child: GestureDetector(
              onTap: () =>
                  BlocProvider.of<PaymentCubit>(context).changeSelect(e.key),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PymantItemSelected(
                  isActive:
                      BlocProvider.of<PaymentCubit>(context).selectindex ==
                              e.key
                          ? true
                          : false,
                  paymantModel: e.value,
                ),
              ),
            ));
          }).toList(),
        );
      },
    );
  }
}
