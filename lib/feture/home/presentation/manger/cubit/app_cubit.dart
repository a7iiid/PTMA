import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/feture/google_map/manegar/map_service.dart';

import '../../../../google_map/manegar/cubit/map_cubit_cubit.dart';
import '../../../../history/history_page.dart';
import '../../../../payment/qr_pymant.dart';
import '../../../../user_profile/profile_page.dart';
import '../../view/widget/home_body.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static get(context) => BlocProvider.of<AppCubit>(context);
  int selectedPage = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          // color: selectedPage == 0 ? Colors.blue : Colors.black,
        ),
        label: 'Location'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.qr_code_scanner_outlined,
          // color: selectedPage == 1 ? Colors.blue : Colors.black,
        ),
        label: 'Location'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.history,
          // color: selectedPage == 2 ? Colors.blue : Colors.black,
        ),
        label: 'Location'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          // color: selectedPage == 3 ? Colors.blue : Colors.black,
        ),
        label: 'Location'),
  ];

  List<Widget> pages = const [
    MainHomePage(),
    QrCodePage(),
    TripHistoryPage(),
    ProfilePage()
  ];

  Widget onTapNav(int index) {
    if (index != 0) {
      MapService.positionStream?.cancel();
    }
    selectedPage = index;
    emit(AppChangeScreen(activeTab: index));
    return pages[index];
  }
}
