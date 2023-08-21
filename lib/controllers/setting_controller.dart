import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../loaders/custom_dialog.dart';
import '../models/timer_data_model.dart';
import '../utilities/widgets.dart';
import 'base_controller.dart';

class SettingController extends GetxController {
  final BaseController _baseController = Get.find<BaseController>();
  RxList<TimerDataModel> timerData = <TimerDataModel>[].obs;

  Future getTimerData(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/get-Timer', body)
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
      timerData.value = List<TimerDataModel>.from(
          result['data'].map((x) => TimerDataModel.fromJson(x)));
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
