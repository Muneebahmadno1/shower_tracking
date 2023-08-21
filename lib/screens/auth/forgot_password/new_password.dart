import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/constants.dart';

import '../../../utilities/custom_text_field.dart';
import '../../../utilities/custom_validators.dart';
import '../../../utilities/global_variables.dart';
import '../../../utilities/widgets.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({Key? key, required this.map}) : super(key: key);
  Map<String, String> map;
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool passwordVisible = true;
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
                  height: 5.h,
                ),
                const Text(
                  "Set New Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 3.h,
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
                AppButton1(
                    text: "Set",
                    btnPressed: () {
                      setState(() {
                        variable = true;
                      });
                      if (formKey.currentState!.validate()) {
                        // widget.map.addAll(
                        //     {"password": _passwordController.text.toString()});
                        // _authController.newPassword(widget.map, context);
                        // Get.to(()=>const SubscribeScreen());
                      }
                    }),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
