import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/widget/custom_button.dart';

import '../../../../core/utils/rout.dart';
import '../../../../core/widget/custom_teaxt_form_field.dart';
import '../../manger/cubit/auth_cubit.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

import '../widget/social_log_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  @override
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final emailControlar = TextEditingController();

  final pasControlar = TextEditingController();

  Widget preficon = SvgPicture.asset(Assets.imagesIsTrue);

  bool isEmail = false;

  bool isPass = false;

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
          child: BlocBuilder<AuthAppCubit, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 33,
                    ),
                    Text(
                      'Login here'.tr(context),
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
                      'Welcome back to\nPTMA'.tr(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 74),
                    CustomTeaxtFormField(
                      controlar: emailControlar,
                      validatText: 'pleas Enter email'.tr(context),
                      hintText: 'Email'.tr(context),
                      labelText: 'Email'.tr(context),
                    ),
                    const SizedBox(height: 29),
                    CustomTeaxtFormField(
                      controlar: pasControlar,
                      validatText: "pleas Enter Passwored".tr(context),
                      hintText: 'Password'.tr(context),
                      labelText: 'Password'.tr(context),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (emailControlar.text != '' &&
                                emailControlar.text.isNotEmpty) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Reset Password'.tr(context),
                                desc: 'Please check your email'.tr(context),
                                btnOkOnPress: () {},
                              )..show();
                              await AuthAppCubit.get(context)
                                  .forgetPassword(emailControlar.text);
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Enter Email'.tr(context),
                                desc: 'Enter your email'.tr(context),
                                btnOkOnPress: () {
                                  //  Navigator.of(context).pop();
                                },
                              )..show();
                            }
                          },
                          child: Text(
                            'Forgot your password?'.tr(context),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF1F41BB),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              'Sign in'.tr(context),
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
                          AuthAppCubit.get(context).login(
                              emailControlar.text, pasControlar.text, context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).push(Routes.kSignUpScreen);
                      },
                      child: Text(
                        'Create new account'.tr(context),
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
            },
          ),
        )),
      ),
    );
  }
}
