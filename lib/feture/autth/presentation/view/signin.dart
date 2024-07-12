import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/widget/custom_button.dart';

import '../../../../core/widget/custom_teaxt_form_field.dart';
import '../../manger/cubit/auth_cubit.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';

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
                      'Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                      'Welcome back you’ve\nbeen missed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(heigt:74)
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
                    CustomButton(
                      title: 'Login'.tr(context),
                      backgraondColor: const Color(0xFF2743FB),
                      textStyle: AppStyle.reguler20white,
                      iconcolor: Colors.white,
                      function: () {
                        if (key.currentState!.validate()) {
                          AuthAppCubit.get(context).login(
                              emailControlar.text, pasControlar.text, context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text('or using social '.tr(context)))
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
