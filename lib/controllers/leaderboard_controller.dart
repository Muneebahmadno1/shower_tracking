import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_cool/models/current_leaderboard_model.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../loaders/custom_dialog.dart';
import '../models/past_leaderboard_model.dart';
import '../utilities/widgets.dart';
import 'base_controller.dart';

class LeadersboardController extends GetxController {
  RxBool leaders = false.obs;
  final BaseController _baseController = Get.find<BaseController>();
  RxList<CurrentLeaderModel> currentLeaderData = <CurrentLeaderModel>[].obs;
  RxList<PastLeaderModel> pastLeaderData = <PastLeaderModel>[].obs;

  Future getCurrentLeaderboard(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/leaderboard', body)
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
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      currentLeaderData.value = List<CurrentLeaderModel>.from(
          result['data'].map((x) => CurrentLeaderModel.fromJson(x)));
      // SnackMessage = result['message'];
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

  Future getPastLeaderboard(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/leaderboard', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    leaders.value = true;
    if (response == null) return;
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      pastLeaderData.value = List<PastLeaderModel>.from(
          result['data'].map((x) => PastLeaderModel.fromJson(x)));
      // SnackMessage = result['message'];
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
