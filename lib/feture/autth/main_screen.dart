import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/utils/rout.dart';
import 'package:ptma/core/utils/shapes/main_screen_shape.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';

import '../../core/widget/custom_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //  scrollBehavior: ScrollBehavior(),
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
              child: CustomPaint(
            size: Size(
                MediaQuery.sizeOf(context).width,
                (MediaQuery.sizeOf(context).width * .4982456140350877)
                    .toDouble()),
            painter: RPSCustomPainter(),
          )),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 21, left: 21),
                  child: CustomButton(
                    title: 'Sign in'.tr(context),
                    function: () {
                      GoRouter.of(context).push(Routes.kSigninScreen);
                    },
                  ),
                ),
                const SizedBox(
                  height: 42,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 21, left: 21),
                  child: CustomButton(
                    title: 'Sign up'.tr(context),
                    backgraondColor: Colors.white,
                    textStyle: AppStyle.reguler20white,
                    iconcolor: const Color(0xFF2743FB),
                    function: () {
                      GoRouter.of(context).push(Routes.kSignUpScreen);
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
