import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/utilities/constants.dart';

import '../utilities/styles.dart';
import '../utilities/widgets.dart';

class CustomDialogBox {
  static Future<dynamic> confirmationDialog(
      {required BuildContext context,
      required String title,
      required VoidCallback? btnYesPressed,
      required VoidCallback? btnNoPressed}) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                height: 25.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: AppColors.hintColor,
                      ),
                      height: 5.h,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                title,
                                // 'Are you sure you want to apply this class',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      fixedSize: Size(100.w, 5.h),
                                    ),
                                    onPressed: btnYesPressed,
                                    child: const Center(
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.hintColor,
                                      elevation: 2,
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                          color: AppColors.hintColor,
                                          width: 1.5),
                                      fixedSize: Size(100.w, 5.h),
                                    ),
                                    onPressed: btnNoPressed,
                                    child: const Center(
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
        });
  }

  static Future<dynamic> requiredPasswordDialog({
    required BuildContext context,
    required VoidCallback? btnYesPressed,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                height: 25.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: AppColors.hintColor,
                      ),
                      height: 5.h,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Please enter your password',
                                // 'Are you sure you want to apply this class',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 5.h,
                            width: 64.w,
                            decoration: const BoxDecoration(),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 5, top: 3, bottom: 3),
                                child: TextField(
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                  onChanged: (value) {},
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.3))),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8.0, bottom: 12.0, top: 5.0),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      fixedSize: Size(100.w, 5.h),
                                    ),
                                    onPressed: btnYesPressed,
                                    child: const Center(
                                      child: Text(
                                        'oK',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
        });
  }

  // TODO: show success dialog

  static void showErrorDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    VoidCallback? btnYesPressed,
    required BuildContext context,
  }) {
    // Get.dialog(
    //   Dialog(
    //     child: SizedBox(
    //       height: 30.h,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: const BorderRadius.only(
    //                     bottomLeft: Radius.circular(10),
    //                     bottomRight: Radius.circular(10),
    //                     topRight: Radius.circular(0),
    //                     topLeft: Radius.circular(0)),
    //                 color: AppColors.hintColor,
    //               ),
    //               height: 13.h,
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: 11.h,
    //                     child: const Center(
    //                       child: Icon(
    //                         Icons.error,
    //                         color: Colors.red,
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               )),
    //           Expanded(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Center(
    //                   child: Text(
    //                     title,
    //                     // 'Are you sure you want to apply this class',
    //                     style: const TextStyle(
    //                         fontSize: 18, fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Center(
    //                   child: Text(
    //                     description!,
    //                     style: const TextStyle(
    //                         fontSize: 14, fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                   child: ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       foregroundColor: AppColors.hintColor,
    //                       elevation: 2,
    //                       backgroundColor: Colors.white,
    //                       side: BorderSide(
    //                           color: AppColors.hintColor, width: 1.5),
    //                       fixedSize: const Size(80, 13),
    //                     ),
    //                     onPressed: btnYesPressed ??
    //                         () {
    //                           if (Get.isDialogOpen!) Get.back();
    //                         },
    //                     child: const Center(
    //                       child: Text(
    //                         'Ok',
    //                         style: TextStyle(
    //                           fontSize: 15,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              // title: Text("Notice"),
              // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Icon(
                        Icons.error,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        title,
                        style: textStyleBlackB.copyWith(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description!,
                        style: textStyleBlackR.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        width: 150,
                        height: 45,
                        child: AppButton1(
                          text: "OK",
                          btnPressed: () {
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  static void showSuccessDialog({
    description = '',
    VoidCallback? btnYesPressed,
  }) {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 30.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    color: AppColors.hintColor,
                  ),
                  height: 15.h,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                        child: const Center(
                          child: Icon(Icons.done),
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        description,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.hintColor,
                          elevation: 2,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: AppColors.hintColor, width: 1.5),
                          fixedSize: const Size(80, 13),
                        ),
                        onPressed: btnYesPressed ??
                            () {
                              if (Get.isDialogOpen!) Get.back();
                            },
                        child: const Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void loginDialog() {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              if (Get.isDialogOpen!) Get.back();
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              size: 20,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Please sign In',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.hintColor,
                          elevation: 2,
                          backgroundColor: AppColors.hintColor,
                          side: BorderSide(
                              color: AppColors.hintColor, width: 1.5),
                          fixedSize: const Size(80, 12),
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen!) Get.back();
                        },
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.black,
              ),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
