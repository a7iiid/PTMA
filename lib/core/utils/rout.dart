import 'package:go_router/go_router.dart';
import 'package:ptma/feture/autth/main_screen.dart';
import 'package:ptma/feture/autth/presentation/view/signin.dart';
import 'package:ptma/feture/autth/presentation/view/signup.dart';
import 'package:ptma/feture/home/presentation/view/home_page.dart';
import 'package:ptma/core/utils/splash/splash.dart';

import '../../feture/home/presentation/view/widget/selcted_routs.dart';

abstract class Routes {
  static const kMainScreen = '/mainScreen';
  static const kSigninScreen = '/signinscreen';
  static const kSignUpScreen = '/signupscreen';
  static const kHomePage = '/homepage';
  static const kSelectRouts = '/selectrout';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashView();
      },
    ),
    GoRoute(
      path: kMainScreen,
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: kSigninScreen,
      builder: (context, state) {
        return const SignInScreen();
      },
    ),
    GoRoute(
      path: kSignUpScreen,
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: kHomePage,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: kSelectRouts,
      builder: (context, state) {
        return SelectRouts();
      },
    ),
  ]);
}
