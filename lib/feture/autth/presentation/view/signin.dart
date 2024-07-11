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
            child: form(
              emailControlar: emailControlar,
              pasControlar: pasControlar,
              formKey: key,
            ),
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
      required this.formKey});

  final emailControlar;

  final pasControlar;
  GlobalKey<FormState> formKey;
  Widget preficon = SvgPicture.asset(Assets.imagesIsTrue);

  bool isEmail = false;
  bool isPass = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthAppCubit(),
      child: BlocBuilder<AuthAppCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.imagesLogin,
                ),
                Text("Login".tr(context), style: AppStyle.bold28blak),
                const SizedBox(
                  height: 33,
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
                  title: 'Login'.tr(context),
                  backgraondColor: const Color(0xFF2743FB),
                  textStyle: AppStyle.reguler20white,
                  iconcolor: Colors.white,
                  function: () {
                    if (formKey.currentState!.validate()) {
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
    );
  }
}
