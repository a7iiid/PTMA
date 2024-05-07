import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/widget/custom_teaxt_form_field.dart';
import 'package:ptma/core/widget/user_image.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'package:ptma/feture/user_profile/presntation/view/widget/change_pictaer.dart';

import '../../../../../core/utils/Style.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../autth/manger/cubit/auth_cubit.dart';
import '../../../../autth/presentation/widget/set_user_image.dart';
import 'build_dialog.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);

  TextEditingController emailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .25,
                  ),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return ChangePicturs();
                    },
                  ),
                  CustomTeaxtFormField(
                    controlar: nameController,
                    validatText: 'pleas Enter name'.tr(context),
                    hintText: 'Full name'.tr(context),
                    labelText: 'Full name'.tr(context),
                  ),
                  CustomTeaxtFormField(
                    controlar: emailController,
                    validatText: 'pleas Enter email'.tr(context),
                    hintText: 'Email'.tr(context),
                    labelText: 'Email'.tr(context),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    title: 'Save'.tr(context),
                    backgraondColor: const Color(0xFF2743FB),
                    textStyle: AppStyle.reguler20white,
                    iconcolor: Colors.white,
                    function: () async {
                      if (key.currentState!.validate()) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return buildDialog(context);
                          },
                        );
                        AppCubit.get(context).editProfile(nameController.text,
                            emailController.text, passController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
