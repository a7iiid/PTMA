import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/rout.dart';
import 'package:ptma/core/widget/custom_button.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.imagesSignin,
                ),
                const SizedBox(
                  height: 130,
                ),
                const Text('Login', style: AppStyle.bold28blak),
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
                    setState(() {});
                    if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      isEmail = true;
                    } else {
                      isEmail = false;
                    }
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
                      suffix: isPass ? preficon : null,
                      label: const Text('Passwored'),
                      enabledBorder: const UnderlineInputBorder()),
                  onChanged: (value) {
                    if (value.length > 7) {
                      isPass = true;
                    } else {
                      isPass = false;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  title: 'Login',
                  backgraondColor: const Color(0xFF2743FB),
                  textStyle: AppStyle.reguler20white,
                  iconcolor: Colors.white,
                  function: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailControlar.text,
                          password: pasControlar.text);

                      GoRouter.of(context).pushReplacement(routes.kHomePage);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                const Align(
                    alignment: Alignment.center,
                    child: const Text('or using social '))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
