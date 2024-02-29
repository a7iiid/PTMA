import 'package:go_router/go_router.dart';
import 'package:ptma/feture/autth/main_screen.dart';
import 'package:ptma/feture/autth/view/signin.dart';
import 'package:ptma/splash/splash.dart';

abstract class routes {
  static const kMainScreen = '/mainScreen';
  static const kSigninScreen = '/signinscreen';
  static const kSignUpScreen = '/signupscreen';

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
        return const SignInScreen();
      },
    ),
  ]);
}
