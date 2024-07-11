import 'package:flutter/widgets.dart';

import 'paymant details/paymantSelected.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [PymantSelected()],
      ),
    );
  }
}
