import 'package:bloc/bloc.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/ApiServes/map_service.dart';

import '../../../../../core/utils/cach/cach_helpar.dart';
import '../../../../../core/utils/image_picker/image_picer.dart';
import '../../../../google_map/manegar/cubit/map_cubit.dart';
import '../../../../history/presantation/history_page.dart';
import '../../../../payment/view/paymant_details_view.dart';
import '../../../../user_profile/presntation/view/profile_page.dart';
import '../../view/widget/home_body.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int selectedPage = 0;
  bool isDisposed = false;
  bool isArabic = false;
  late AuthCredential credential;
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

  Future<AuthCredential> confirmConiction(String pass) async {
    User user = FirebaseAuth.instance.currentUser!;

    credential =
        EmailAuthProvider.credential(email: user.email!, password: pass);
    return credential;
  }

  Future<void> editProfile(String newName, String newEmail, String pass) async {
    User user = FirebaseAuth.instance.currentUser!;

    await user.reauthenticateWithCredential(credential).then((value) async {
      await user.updateDisplayName(newName); //change new name
      await user.verifyBeforeUpdateEmail(newEmail); //
      //uplode new image
      if (pickImageServes.file != null) {
        await pickImageServes.uplode();

        await user.updatePhotoURL(pickImageServes.url);
      }
      emit(EditProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(EditProfileFaiur());
    });
  }
}
