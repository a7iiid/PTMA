import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/rout.dart';
import 'package:ptma/core/utils/shapes/main_screen_shape.dart';

import '../../core/widget/custom_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomPaint(
              size: const Size(375, 572),
              painter: RPSCustomPainter(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 21, left: 21),
                  child: CustomButton(
                    title: 'Sign in',
                    function: () {
                      GoRouter.of(context).push(routes.kSigninScreen);
                    },
                  ),
                ),
                const SizedBox(
                  height: 42,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 21, left: 21),
                  child: CustomButton(
                    title: 'Sign up',
                    backgraondColor: Colors.white,
                    textStyle: AppStyle.reguler20white,
                    iconcolor: const Color(0xFF2743FB),
                    function: () {
                      GoRouter.of(context).push(routes.kSignUpScreen);
                    },
                  ),
                ),
                const SizedBox(
                  height: 31,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
