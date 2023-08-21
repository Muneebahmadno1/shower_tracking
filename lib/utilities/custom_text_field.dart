import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:too_cool/utilities/styles.dart';

import 'constants.dart';

class CustomTextField {
  static Widget authInputFields({
    required String hint,
    // required IconData iconData,
    required TextEditingController textEditingController,
    final TextInputType? keyboardType,
    List<TextInputFormatter>? keys,
    // final Widget? suffixIcon,
    final bool? obscureText,
    FormFieldValidator<String>? validator,
    String? lastText,
    GlobalKey<FormState>? formKey,
    Function? set,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: (value) {
        print("not set");
        if (set != null) {
          print("set");
          set();
        }
      },
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      inputFormatters: keys ?? [],
      validator: validator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          filled: true,
          fillColor: Colors.white,
          hintStyle: textStyleBlackR.copyWith(
              fontSize: 16, color: AppColors.hintColor),
          hintText: hint,
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixText: lastText,
          suffixStyle: textStyleBlackB.copyWith(
              fontSize: 16.0, decoration: TextDecoration.underline),
          prefixText: "   "
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.only(left: 27.0,right: 10.0),
          //   child: Icon(
          //     iconData,
          //     color: AppColors.background,
          //   ),
          // ),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: suffixIcon,
          // ),
          ),
    );
  }
}
