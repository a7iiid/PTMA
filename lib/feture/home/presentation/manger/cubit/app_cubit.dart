import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/ApiServes/map_service.dart';

import '../../../../../core/utils/cach/cach_helpar.dart';
import '../../../../../core/utils/image_picker/image_picer.dart';
import '../../../../google_map/manegar/cubit/map_cubit_cubit.dart';
import '../../../../history/history_page.dart';
import '../../../../payment/view/paymant_details_view.dart';
import '../../../../user_profile/view/profile_page.dart';
import '../../view/widget/home_body.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int selectedPage = 0;
  bool isDisposed = false;
  bool isArabic = false;
  PickImageServes pickImageServes = PickImageServes.get();

  Future<void> SetUserPictur() async {
    emit(ChangeUserPictiurLoding());

    try {
      await pickImageServes.getImageFromGallery();
      emit(ChangeUserPictiurSuccess());
    } catch (e) {
      emit(ChangeUserPictiurFilur());
    }
  }

  List<Widget> pages = [
    HomeBody(),
    PaymentDetails(),
    TripHistoryPage(),
    ProfilePage()
  ];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.blue,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.black,
        ),
        label: 'Pey'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.history,
          color: Colors.black,
        ),
        label: 'History'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        label: 'Profile'),
  ];

  Widget onTapNav(int index) {
    if (index != 0 && !isDisposed) {
      MapService.positionStream?.cancel();
      isDisposed = !isDisposed;
    } else if (index == 0) {
      isDisposed = false;
    }

    selectedPage = index;
    bottomItems = [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: selectedPage == 0 ? Colors.blue : Colors.black,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.qr_code_scanner_outlined,
            color: selectedPage == 1 ? Colors.blue : Colors.black,
          ),
          label: 'Pey'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: selectedPage == 2 ? Colors.blue : Colors.black,
          ),
          label: 'History'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: selectedPage == 3 ? Colors.blue : Colors.black,
          ),
          label: 'Profile'),
    ];

    emit(AppChangeScreen(activeTab: index));
    return pages[index];
  }

  void changeLang(bool lang) {
    if (lang != null) {
      isArabic = lang;
      CachHelper.langPutData('isChick', isArabic);
      print('not null ${CachHelper.langGetData('isChick')}');
      emit(Languegchang());
    } else {
      print(' null $lang');

      isArabic = !isArabic;

      CachHelper.langPutData('isChick', isArabic)
          .then((value) => emit(Languegchang()));
    }
  }
}
