import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../../utilities/global_variables.dart';
import '../../../utilities/widgets.dart';

class VerifyOtp extends StatefulWidget {
  VerifyOtp({Key? key, required this.email}) : super(key: key);
  String email;
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final OtpFieldController _otpController = OtpFieldController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController _authController = Get.find<AuthController>();
  String otp = "";
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
                      "Enter Otp",
                      style: textStyleBlackB,
                    ),
                  ],
                ),
                OTPTextField(
                  length: 4,
                  controller: _otpController,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (value) {},
                  onCompleted: (pin) {
                    // print("Completed: " + pin);
                    setState(() {
                      otp = pin;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppButton1(
                    text: "Verify Otp",
                    btnPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("_otpController.toString()");
                        print(otp.toString());
                        setState(() {
                          variable = true;
                        });

                        // Map<String, String> map = {
                        //   "email": widget.email,
                        //   "forget_code": otp,
                        // };
                        // _authController.verifyCode(map, context);
                        // Get.to(() => const NewPasswordScreen());
                        // if (_otpController.is) {
                        //   Get.to(()=>const VerifyOtp());
                        // }
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
