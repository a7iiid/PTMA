import 'package:flutter/material.dart';

class DashWidget extends StatelessWidget {
  const DashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 28,
      right: 28,
      bottom: MediaQuery.sizeOf(context).height * .2 + 20,
      child: Row(
        children: List.generate(
          30,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: 2,
                color: Color(0xffB8B8B8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
