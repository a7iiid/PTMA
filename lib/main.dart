import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ptma/core/manger/cubit/loclaization_cubit.dart';
import 'package:ptma/core/utils/apiKey.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/utils/them_app.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'core/utils/cach/cach_helpar.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'core/utils/rout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKey.publishableKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CachHelper.init();
  bool isArabic = CachHelper.langGetData('isArabic');
  print('ischick = $isArabic');

  runApp(MyApp(
    isArabic: isArabic,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isArabic});
  bool isArabic;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return LoclaizationCubit()..changeLang(isArabic);
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return AppCubit();
            },
          )
        ],
        child: BlocBuilder<LoclaizationCubit, LoclaizationState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: Routes.router,
              locale: LoclaizationCubit.get(context).isArabic
                  ? Locale('ar')
                  : Locale('en'),
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }

                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeApp.themeapplight,
            );
          },
        ));
  }
}
