import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../utilities/custom_text_field.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/widgets.dart';
import 'forgot_password/send_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthController _authController = Get.find<AuthController>();
  bool loader = false;
  bool passwordVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _authController.getSubscriptions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: AbsorbPointer(
            absorbing: loader,
            child: Form(
              key: formKey,
              child: SizedBox(
                height: 98.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          height: 5.h,
                        ),
                        Text(
                          "Log in to your account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 5.h,
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
                          height: 3.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AppButton1(
                                text: loader ? "" : "Log In",
                                btnPressed: () async {
                                  setState(() {
                                    variable = true;
                                  });
                                  if (formKey.currentState!.validate()) {
                                    Map<String, String> map = {
                                      "email": _emailController.text.toString(),
                                      "password":
                                          _passwordController.text.toString(),
                                    };
                                    setState(() {
                                      loader = true;
                                    });
                                    await _authController.getFCMToken();
                                    Platform.isIOS
                                        ? map.addAll({
                                            "ios_fcm_key":
                                                _authController.fcmToken.value
                                          })
                                        : map.addAll({
                                            "android_fcm_key":
                                                _authController.fcmToken.value
                                          });
                                    await _authController.userLogin(
                                        map, context);
                                    setState(() {
                                      loader = false;
                                    });
                                    // Get.to(() => const SubscribeScreen());
                                  }
                                }),
                            loader
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => const SendOtp());
                                },
                                child: Text("Reset Password?",
                                    style: textStyleBlackB.copyWith(
                                        fontSize: 16))),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Or log in with",
                          style: textStyleBlackR.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SocialLoginButtons().logos(context),
                      ],
                    ),
                    Container(
                        height: 30,
                        alignment: Alignment.topCenter,
                        child: HaveAccount.doNot()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //     height: 60,
      //     alignment: Alignment.topCenter,
      //     child: HaveAccount.doNot()),
    );
  }
}
