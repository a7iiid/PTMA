import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/widget/custom_button.dart';

import '../../manger/cubit/auth_cubit.dart';

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

  @override
  final emailControlar;

  final pasControlar;
  GlobalKey<FormState> formKey;
  Widget preficon = SvgPicture.asset(Assets.imagesIsTrue);

  bool isEmail = false;
  bool isPass = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthAppCubit, AuthState>(builder: (context, state) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.imagesSignup,
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('Sign up', style: AppStyle.bold28blak),
            const SizedBox(
              height: 33,
            ),
            TextFormField(
              controller: emailControlar,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'pleas Enter email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Email Address',
                  suffix: isEmail ? preficon : null,
                  label: const Text('Email'),
                  enabledBorder: const UnderlineInputBorder()),
              onChanged: (value) {
                if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  isEmail = true;
                } else {
                  isEmail = false;
                }
                print(isEmail);
                AuthAppCubit.get(context).inputfilde();
              },
            ),
            TextFormField(
              controller: pasControlar,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'pleas Enter Passwored';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Passwored',
                  suffix: isPass == true ? preficon : null,
                  label: const Text('Passwored'),
                  enabledBorder: const UnderlineInputBorder()),
              onChanged: (value) {
                if (value.length >= 8) {
                  isPass = true;
                } else {
                  isPass = false;
                }
                print(isPass);

                AuthAppCubit.get(context).inputfilde();
              },
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
                  AuthAppCubit.get(context)
                      .login(emailControlar.text, pasControlar.text, context);
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
    });
  }
}
