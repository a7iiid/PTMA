import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/core/utils/ApiServes/map_service.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import '../../../../../core/utils/image_picker/image_picer.dart';
import '../../../../google_map/view/homemap.dart';
import '../../../../history/presantation/history_page.dart';
import '../../../../payment/view/paymant_details_view.dart';
import '../../view/widget/selcted_routs.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int selectedPage = 0;
  bool isDisposed = false;
  bool isArabic = false;
  late AuthCredential credential;
  PickImageServes pickImageServes = PickImageServes.get();
  List<BottomNavigationBarItem> bottomItems = [];
//////////////////////////

  Future<void> setUserPictur() async {
    emit(ChangeUserPictiurLoding());

    try {
      await pickImageServes.getImageFromGallery();
      emit(ChangeUserPictiurSuccess());
    } catch (e) {
      emit(ChangeUserPictiurFilur());
    }
  }

//list screen
  List<Widget> pages = [
    SelectRouts(),
    MapPage(),
    const PaymentDetails(),
    const TripHistoryPage(),
  ];

  void init(context) {
    bottomItems = [
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.home,
            color: Colors.blue,
          ),
          label: 'Home'.tr(context)),
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.map_outlined,
            color: Colors.black,
          ),
          label: 'Map'.tr(context)),
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.qr_code_scanner_outlined,
            color: Colors.black,
          ),
          label: 'Pay'.tr(context)),
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.history,
            color: Colors.black,
          ),
          label: 'History'.tr(context)),
    ];
  }

  Widget onTapNav(int index, context) {
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
          label: 'Home'.tr(context)),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.map_outlined,
            color: selectedPage == 1 ? Colors.blue : Colors.black,
          ),
          label: 'Map'.tr(context)),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.qr_code_scanner_outlined,
            color: selectedPage == 2 ? Colors.blue : Colors.black,
          ),
          label: 'Pay'.tr(context)),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: selectedPage == 3 ? Colors.blue : Colors.black,
          ),
          label: 'History'.tr(context)),
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
