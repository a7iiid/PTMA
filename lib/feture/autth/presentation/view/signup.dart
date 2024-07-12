import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/utils/rout.dart';
import 'package:ptma/feture/autth/manger/cubit/auth_cubit.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_teaxt_form_field.dart';
import '../widget/set_user_image.dart';
import '../widget/social_log_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final emailControlar = TextEditingController();

  final pasControlar = TextEditingController();
  final nameControlar = TextEditingController();

  @override
  void dispose() {
    emailControlar.dispose();
    pasControlar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        body: SafeArea(
            child: BlocProvider(
          create: (context) => AuthAppCubit(),
          child: BlocConsumer<AuthAppCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Create Account'.tr(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF1F41BB),
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Text(
                        'Create an account so you can explore\nall the servis'
                            .tr(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      SetUserImage(),
                      CustomTeaxtFormField(
                        controlar: nameControlar,
                        validatText: 'pleas Enter name'.tr(context),
                        hintText: 'Full name'.tr(context),
                        labelText: 'Full name'.tr(context),
                      ),
                      CustomTeaxtFormField(
                        controlar: emailControlar,
                        validatText: 'pleas Enter email'.tr(context),
                        hintText: 'Email'.tr(context),
                        labelText: 'Email'.tr(context),
                      ),
                      CustomTeaxtFormField(
                        controlar: pasControlar,
                        validatText: "pleas Enter Passwored".tr(context),
                        hintText: 'Password'.tr(context),
                        labelText: 'Password'.tr(context),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        child: Container(
                          width: 357,
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F41BB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0xFFCAD6FF),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign up'.tr(context),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (key.currentState!.validate()) {
                            AuthAppCubit.get(context).creatAcaunte(
                                emailControlar.text,
                                pasControlar.text,
                                nameControlar.text,
                                context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Already have an account'.tr(context),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF494949),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SocialLogIn()
                    ],
                  ),
                );
              }),
        )),
      ),
    );
  }
}
