import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../loaders/custom_dialog.dart';
import '../models/showers_model.dart';
import '../screens/navigation_bar/navigation_bar.dart';
import '../utilities/widgets.dart';
import 'base_controller.dart';

class HomeController extends GetxController {
  final BaseController _baseController = Get.find<BaseController>();
  RxList<ShowersModel> showersData = <ShowersModel>[].obs;
  RxList<ShowersModel> dayShowerData = <ShowersModel>[].obs;
  RxList<DateTime> eventDates = <DateTime>[].obs;

  bool isEventDay(DateTime day) {
    print('day');
    print(day.toString().substring(0, 10));
    // print(eventDates[0].toString().substring(0, 10));
    print(eventDates.contains(DateTime.parse(day.toString().substring(0, 10))));
    return eventDates.contains(DateTime.parse(day.toString().substring(0, 10)));
  }

  Future addSession(
      var body, bool addSession, BuildContext context, int page) async {
    page == 1
        ? _baseController.showLoading('Saving Session...')
        : _baseController.showLoading('Saving Settings...');
    print(body);
    var response = await DataApiService.instance
        .post('/add-timers', body)
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
    if (result['success'] == true && addSession == true) {
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
      if (addSession) {
        Get.offAll(() => const CommonNavigationBar(index: 0));
      }
    } else if (result['success'] == false && addSession == true) {
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

  Future getShowers(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/get-showers', body)
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
      showersData.value = List<ShowersModel>.from(
          result['data'].map((x) => ShowersModel.fromJson(x)));
      for (int i = 0; i < showersData.length; i++) {
        // event[DateTime.parse(showersData[i].date.toString())] = [
        //   DayType.check,
        //   showersData[i].title.toString()
        // ];
        eventDates.add(
            DateTime.parse(showersData[i].date.toString().substring(0, 10)));
      }
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

  Future getDayShowers(var body, BuildContext context) async {
    print(body);
    var response = await DataApiService.instance
        .post('/get-showers', body)
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
      dayShowerData.value = List<ShowersModel>.from(
          result['data'].map((x) => ShowersModel.fromJson(x)));
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

  Future takeShowers(var body, BuildContext context) async {
    _baseController.showLoading('Saving Session...');
    print(body);
    var response = await DataApiService.instance
        .post('/take-shower', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    _baseController.hideLoading();
    if (response == null) return;
    print("response");
    print(response);
    final result = jsonDecode(response);
    if (result['success'] == true) {
      // SnackMessage = result['message'];
      Get.offAll(() => const CommonNavigationBar(index: 0));
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
