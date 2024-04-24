import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
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
                  const Row(
                    children: [
                      Text('Sign up', style: AppStyle.bold28blak),
                      Spacer()
                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  SetUserImage(),
                  UserNameInput(nameControlar: nameControlar),
                  CustomTeaxtFormField(
                    controlar: emailControlar,
                    validatText: 'pleas Enter email',
                    hintText: 'Email',
                    labelText: 'Email',
                  ),
                  CustomTeaxtFormField(
                    controlar: pasControlar,
                    validatText: "pleas Enter Passwored",
                    hintText: 'Passwored',
                    labelText: 'Passwored',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: 'Sign up',
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
                  const Align(
                      alignment: Alignment.center,
                      child: Text('or using social '))
                ],
              ),
            );
          }),
    );
  }
}
