import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/constants.dart';

import '../../../utilities/custom_text_field.dart';
import '../../../utilities/custom_validators.dart';
import '../../../utilities/global_variables.dart';
import '../../../utilities/styles.dart';
import '../../../utilities/widgets.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
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
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your email",
                      style: textStyleBlackB,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField.authInputFields(
                  hint: 'Email Address',
                  validator: (value) => CustomValidator.email(value),
                  textEditingController: _emailController,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppButton1(
                    text: "Send Otp",
                    btnPressed: () {
                      setState(() {
                        variable = true;
                      });
                      if (formKey.currentState!.validate()) {
                        // Map<String, String> map = {
                        //   "email": _emailController.text.toString(),
                        // };
                        // _authController.forgotPassword(map, context);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
