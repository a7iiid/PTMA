import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ptma/core/manger/cubit/loclaization_cubit.dart';
import 'package:ptma/core/utils/apiKey.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/utils/them_app.dart';
import 'package:ptma/feture/google_map/manegar/cubit/driver_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';
import 'package:ptma/feture/history/data/repo/history_repo_implemant_hive.dart';
import 'package:ptma/feture/history/presantation/manegar/cubit/history_cubit.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'core/utils/cach/cach_helpar.dart';
import 'feture/google_map/manegar/cubit/map_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/utils/rout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKey.publishableKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CachHelper.init();
  bool isArabic = CachHelper.langGetData('isArabic');
  Hive.registerAdapter(ColorAdapter());

  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelAdapter());
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
            create: (context) => MapCubit()..mapServiceApp(),
          ),
          BlocProvider(
            create: (BuildContext context) {
              return LoclaizationCubit()..changeLang(isArabic);
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return AppCubit();
            },
          ),
          BlocProvider(
            create: (context) => SelectRoutCubit(),
          ),
          BlocProvider(
            create: (context) => DriverCubit(),
          ),
          BlocProvider(
            create: (context) =>
                HistoryCubit(historyRepo: HistoryRepoImplemantHive()),
          ),
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
