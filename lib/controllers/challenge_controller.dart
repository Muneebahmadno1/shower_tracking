import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_cool/controllers/base_controller.dart';
import 'package:too_cool/models/challenges_model.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../loaders/custom_dialog.dart';
import '../screens/challenges/finish_creating_new_challenge.dart';
import '../utilities/widgets.dart';

class ChallengeController extends GetxController {
  RxBool challenge = false.obs;
  final BaseController _baseController = Get.find<BaseController>();
  RxList<ChallengesModel> challenges = <ChallengesModel>[].obs;

  Future createChallenge(var body, BuildContext context) async {
    _baseController.showLoading('Creating Challenge...');
    print(body);
    var response = await DataApiService.instance
        .post('/create-challenge', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      // SnackMessage = result['message'];
      await successDialog(context, "Success", result['info']);
      // await QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
      Get.to(() => FinishCreatingNewChallengeScreen(
            shareCode: result['data']['share_code'],
          ));
    } else if (result['success'] == false) {
      // SnackMessage = result['message'];
      errorDialog(context, "Error", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.error,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
    }
    // var req = {
    //   'email': body['email'],
    //   'password': body['password'],
    // };
    // userLogin(req);
  }

  Future getChallenge(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/challenges', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    challenge.value = true;
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      // SnackMessage = result['message'];
      challenges.value = List<ChallengesModel>.from(
          result['challenges'].map((x) => ChallengesModel.fromJson(x)));
    } else if (result['success'] == false) {
      // SnackMessage = result['message'];
      errorDialog(context, "Error", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.error,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
    }
    // var req = {
    //   'email': body['email'],
    //   'password': body['password'],
    // };
    // userLogin(req);
  }

  Future joinChallenge(var body, BuildContext context) async {
    _baseController.showLoading('Joining Challenge...');
    print(body);
    var response = await DataApiService.instance
        .post('/join-challenge', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      // SnackMessage = result['message'];
      await successDialog(context, "Success", result['info']);
      // await QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
      Get.offAll(const CommonNavigationBar(index: 3));
    } else if (result['success'] == false) {
      // SnackMessage = result['message'];
      errorDialog(context, "Error", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.error,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
    }
    // var req = {
    //   'email': body['email'],
    //   'password': body['password'],
    // };
    // userLogin(req);
  }

  Future updateChallenge(var body, BuildContext context) async {
    _baseController.showLoading('Updating Challenge...');
    print(body);
    var response = await DataApiService.instance
        .post('/update-challenge', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      // SnackMessage = result['message'];
      successDialog(context, "Success", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
    } else if (result['success'] == false) {
      // SnackMessage = result['message'];
      errorDialog(context, "Error", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.error,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //   },
      // );
    }
    // var req = {
    //   'email': body['email'],
    //   'password': body['password'],
    // };
    // userLogin(req);
  }
}
