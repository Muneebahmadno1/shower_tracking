import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../utilities/constants.dart';
import '../../utilities/custom_text_field.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool passwordVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Image.asset(
                      Asset.appLogo,
                      scale: 5.0,
                    )),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  "Create your account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField.authInputFields(
                  hint: 'Full Name',
                  // iconData: Icons.lock,
                  validator: (value) => CustomValidator.isEmptyUserName(value),
                  textEditingController: _nameController,
                  // obscureText: _passwordVisible,
                  // suffixIcon: InkWell(
                  //   highlightColor: Colors.transparent,
                  //   splashColor: Colors.transparent,
                  //   onTap: () {
                  //     setState(() {
                  //       _passwordVisible = !_passwordVisible;
                  //     });
                  //   },
                  //   child: Icon(
                  //     _passwordVisible
                  //         ? CupertinoIcons.eye
                  //         : CupertinoIcons.eye_slash,
                  //     color: AppColors.background,
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                    hint: 'Email Address',
                    // iconData: Icons.lock,
                    validator: (value) => CustomValidator.email(value),
                    textEditingController: _emailController,
                    keyboardType: TextInputType.emailAddress
                    // obscureText: _passwordVisible,
                    // suffixIcon: InkWell(
                    //   highlightColor: Colors.transparent,
                    //   splashColor: Colors.transparent,
                    //   onTap: () {
                    //     setState(() {
                    //       _passwordVisible = !_passwordVisible;
                    //     });
                    //   },
                    //   child: Icon(
                    //     _passwordVisible
                    //         ? CupertinoIcons.eye
                    //         : CupertinoIcons.eye_slash,
                    //     color: AppColors.background,
                    //   ),
                    // ),
                    ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                  hint: 'Password',
                  // iconData: Icons.lock,
                  validator: (value) => CustomValidator.password(value),
                  textEditingController: _passwordController,
                  obscureText: passwordVisible,
                  // suffixIcon: InkWell(
                  //   highlightColor: Colors.transparent,
                  //   splashColor: Colors.transparent,
                  //   onTap: () {
                  //     setState(() {
                  //       _passwordVisible = !_passwordVisible;
                  //     });
                  //   },
                  //   child: Icon(
                  //     _passwordVisible
                  //         ? CupertinoIcons.eye
                  //         : CupertinoIcons.eye_slash,
                  //     color: AppColors.background,
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                  hint: 'Confirm Password',
                  // iconData: Icons.lock,
                  validator: (value) => CustomValidator.confirmPassword(
                      value, _passwordController.text),
                  textEditingController: _confirmPasswordController,
                  obscureText: passwordVisible,
                ),
                SizedBox(
                  height: 3.h,
                ),
                AppButton1(
                    text: "Sign Up",
                    btnPressed: () async {
                      setState(() {
                        variable = true;
                      });
                      if (formKey.currentState!.validate()) {
                        Map<String, String> map = {
                          "email": _emailController.text.toString(),
                          "password": _passwordController.text.toString(),
                          "name": _nameController.text.toString(),
                        };
                        await _authController.getFCMToken();
                        Platform.isIOS
                            ? map.addAll(
                                {"ios_fcm_key": _authController.fcmToken.value})
                            : map.addAll({
                                "android_fcm_key":
                                    _authController.fcmToken.value
                              });
                        await _authController.userRegister(map, context);
                      }
                    }),
                SizedBox(
                  height: 3.h,
                ),
                Text("Or sign up with",
                    style: textStyleBlackR.copyWith(fontSize: 16)),
                SizedBox(
                  height: 3.h,
                ),
                SocialLoginButtons().logos(context),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 35,
                  alignment: Alignment.topCenter,
                  child: HaveAccount.already(),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 35,
      //   alignment: Alignment.topCenter,
      //   child: HaveAccount.already(),
      // ),
    );
  }
}
