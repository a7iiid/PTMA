import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/Style.dart';

class TotlePrise extends StatelessWidget {
  TotlePrise({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.bold24,
        ),
        Text(
          value,
          style: AppStyle.bold24,
        ),
      ],
    );
  }
}
