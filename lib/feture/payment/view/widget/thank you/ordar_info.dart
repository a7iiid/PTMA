import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/Style.dart';

class OrdarInfo extends StatelessWidget {
  OrdarInfo({super.key, required this.data, required this.title});
  final String title, data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyle.regylar18,
          ),
          Text(
            data,
            style: AppStyle.bolde18,
          ),
        ],
      ),
    );
  }
}
