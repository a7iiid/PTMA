import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/rout.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> sliderAnimation;

  @override
  void initState() {
    super.initState();

    initSlideAnimated();
    NavToHome();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
          animation: sliderAnimation,
          builder: (context, child) => SlideTransition(
            position: sliderAnimation,
            child: Center(
              child: Image.asset('assets/images/splash.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  void initSlideAnimated() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    sliderAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(animationController);
    sliderAnimation.addListener(() {});
    animationController.forward();
  }

  void NavToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(const HomeView(),
      // transition: Transition.downToUp, duration: TransitionDuretion);
      if (FirebaseAuth.instance.currentUser == null) {
        GoRouter.of(context).pushReplacement(Routes.kMainScreen);
      } else {
        GoRouter.of(context).pushReplacement(Routes.kHomePage);
      }
    });
  }
}
