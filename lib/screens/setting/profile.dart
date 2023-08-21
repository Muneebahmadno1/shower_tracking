import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/auth_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  AuthController authController = Get.find();
  bool passwordVisible = true;
  XFile? imageFile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _getFromGallery() async {
    imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Profile Information",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: 85.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      imageFile == null
                          ? Image.asset(
                              Asset.userIcon,
                              scale: 2.0,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      SizedBox(
                        width: 40.w,
                        height: 45,
                        child: AppButton1(
                            fontSize: 16,
                            text: "Change Avatar",
                            btnPressed: () {
                              _getFromGallery();
                            }),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      // CustomTextField.authInputFields(
                      //   hint: 'Full Name',
                      //   // iconData: Icons.lock,
                      //   validator: (value) =>
                      //       CustomValidator.isEmptyUserName(value),
                      //   textEditingController: _nameController,
                      //   // obscureText: _passwordVisible,
                      //   // suffixIcon: InkWell(
                      //   //   highlightColor: Colors.transparent,
                      //   //   splashColor: Colors.transparent,
                      //   //   onTap: () {
                      //   //     setState(() {
                      //   //       _passwordVisible = !_passwordVisible;
                      //   //     });
                      //   //   },
                      //   //   child: Icon(
                      //   //     _passwordVisible
                      //   //         ? CupertinoIcons.eye
                      //   //         : CupertinoIcons.eye_slash,
                      //   //     color: AppColors.background,
                      //   //   ),
                      //   // ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // CustomTextField.authInputFields(
                      //   hint: 'Email Address',
                      //   // iconData: Icons.lock,
                      //   validator: (value) => CustomValidator.email(value),
                      //   textEditingController: _emailController,
                      //   // obscureText: _passwordVisible,
                      //   // suffixIcon: InkWell(
                      //   //   highlightColor: Colors.transparent,
                      //   //   splashColor: Colors.transparent,
                      //   //   onTap: () {
                      //   //     setState(() {
                      //   //       _passwordVisible = !_passwordVisible;
                      //   //     });
                      //   //   },
                      //   //   child: Icon(
                      //   //     _passwordVisible
                      //   //         ? CupertinoIcons.eye
                      //   //         : CupertinoIcons.eye_slash,
                      //   //     color: AppColors.background,
                      //   //   ),
                      //   // ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // CustomTextField.authInputFields(
                      //     hint: 'Password',
                      //     // iconData: Icons.lock,
                      //     validator: (value) => CustomValidator.password(value),
                      //     textEditingController: _passwordController,
                      //     obscureText: passwordVisible,
                      //     lastText: "Change"),
                    ],
                  ),
                  AppButton1(
                      text: "Save Information",
                      btnPressed: () {
                        setState(() {
                          variable = true;
                        });
                        if (formKey.currentState!.validate()) {
                          authController.updateProfile(
                              imageFile!.path, context);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
