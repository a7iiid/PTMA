import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/feture/autth/manger/cubit/auth_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit_cubit.dart';

import 'package:ptma/feture/history/history_page.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'package:ptma/feture/payment/qr_pymant.dart';
import 'package:ptma/feture/user_profile/profile_page.dart';

import 'widget/home_body.dart';
import 'widget/head_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
                body: AppCubit.get(context)
                    .pages[AppCubit.get(context).selectedPage],
                bottomNavigationBar: BottomNavigationBar(
                  items: AppCubit.get(context).bottomItems,
                  currentIndex: AppCubit.get(context).selectedPage,
                  onTap: (index) {
                    AppCubit.get(context).onTapNav(index);
                  },
                  selectedItemColor: Colors.blue,
                ));
          },
        ),
      ),
    );
  }
}
