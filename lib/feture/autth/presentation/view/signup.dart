import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/autth/manger/cubit/auth_cubit.dart';
import '../../../../core/utils/image_picker/image_picer.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_teaxt_form_field.dart';
import '../widget/set_user_image.dart';
import '../widget/user_name_input.dart';

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
          child: form(
            emailControlar: emailControlar,
            pasControlar: pasControlar,
            nameControlar: nameControlar,
            formKey: key,
          ),
        ),
      ),
    );
  }
}

class form extends StatelessWidget {
  form(
      {super.key,
      this.emailControlar,
      this.pasControlar,
      this.nameControlar,
      required this.formKey});

  @override
  final emailControlar;
  final nameControlar;

  final pasControlar;
  GlobalKey<FormState> formKey;
  Widget preficon = SvgPicture.asset(Assets.imagesIsTrue);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                  Row(
                    children: [
                      Text('Sign up'.tr(context), style: AppStyle.bold28blak),
                      Spacer()
                    ],
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
                  CustomButton(
                    title: 'Sign up'.tr(context),
                    backgraondColor: const Color(0xFF2743FB),
                    textStyle: AppStyle.reguler20white,
                    iconcolor: Colors.white,
                    function: () {
                      if (formKey.currentState!.validate()) {
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
                  Align(
                      alignment: Alignment.center,
                      child: Text('or using social '.tr(context)))
                ],
              ),
            );
          }),
    );
  }
}
