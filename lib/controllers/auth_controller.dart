import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:too_cool/controllers/base_controller.dart';
import 'package:too_cool/models/subscription_model.dart';
import 'package:too_cool/screens/auth/login_screen.dart';
import 'package:too_cool/screens/auth/subscribe.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../loaders/custom_dialog.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/user_model.dart';
import '../screens/auth/forgot_password/verify_otp.dart';
import '../utilities/constants.dart';
import '../utilities/styles.dart';
import '../utilities/widgets.dart';

class AuthController extends GetxController {
  RxString token = "".obs;
  final BaseController _baseController = Get.find<BaseController>();
  UserModel? userData;
  RxList<SubscriptionModel> subscriptions = <SubscriptionModel>[].obs;
  RxList<CountryModel> countries = <CountryModel>[].obs;
  RxList<CityModel> cities = <CityModel>[].obs;
  GoogleSignInAccount? _currentUser;
  RxString fcmToken = ''.obs;

  /*<---------------------Register--------------------->*/

  getFCMToken() async {
    fcmToken.value = (await FirebaseMessaging.instance.getToken())!;
  }

  Future userRegister(var body, BuildContext context) async {
    _baseController.showLoading('Registering account...');
    print(body);
    var response =
        await DataApiService.instance.post('/signup', body).catchError((error) {
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
      //     Get.offAll(() => const SubscribeScreen());
      //   },
      // );
      userData = UserModel.fromJson(result['data']);
      token.value = userData!.accessToken;
      print('save id is called');
      saveUserDataToken(token: token.value);
      setUserLoggedIn(true);
      setUserType("App");
      // update();
      Get.offAll(() => const SubscribeScreen());
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

  Future userLogin(var body, BuildContext context) async {
    // _baseController.showLoading('Logging user...');
    print(body);
    var response =
        await DataApiService.instance.post('/signin', body).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    // _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      userData = UserModel.fromJson(result['data']);
      token.value = userData!.accessToken;
      print('save id is called');
      saveUserDataToken(token: token.value);
      setUserLoggedIn(true);
      setUserType("App");
      // update();
      Get.offAll(() => const SubscribeScreen());
      return "true";
    } else {
      print("Hello");
      print(result['info']);
      errorDialog(context, "Error", result['info']);
      return "false";
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
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future updateProfile(String body, BuildContext context) async {
    _baseController.showLoading('Updating profile picture...');
    print(body);
    String response = await DataApiService.instance
        .multiPartPost('/update-profile', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["message"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    // if (response == null) return;
    _baseController.hideLoading();
    print("response");
    print(response);
    if (response == "200") {
      // SnackMessage = result['message'];
      await successDialog(context, "Success", "Profile Updated Successfully");
      Get.offAll(() => const CommonNavigationBar(index: 4));
    } else {
      // SnackMessage = result['message'];
      errorDialog(context, "Error", "Something went wrong");
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

  Future forgotPassword(var body, BuildContext context) async {
    _baseController.showLoading('Loading ...');
    var response = await DataApiService.instance
        .post('/forgot_password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (result['success']) {
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
      Get.to(() => VerifyOtp(
            email: body["email"].toString(),
          ));
      // update();
    } else {
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
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future verifyCode(var body, BuildContext context) async {
    _baseController.showLoading('Loading ...');
    var response = await DataApiService.instance
        .post('/code_verify', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      successDialog(context, "Success", result['info']);
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   text: result['info'],
      //   confirmBtnColor: Colors.black,
      //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
      //   onConfirmBtnTap: () {
      //     Get.back();
      //     Get.to(() => NewPasswordScreen(
      //           map: body,
      //         ));
      //   },
      // );
      // Get.to(() => const VerifyOtp());
      // update();
    } else {
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
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future newPassword(var body, BuildContext context) async {
    _baseController.showLoading('Loading ...');
    var response = await DataApiService.instance
        .post('/new_password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
          description: apiError["reason"],
          context: context,
        );
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      // await successDialog(context, "Success", result['info']);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: result['info'],
        confirmBtnColor: Colors.black,
        confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
        onConfirmBtnTap: () {
          Get.back();
          Get.offAll(() => const LoginScreen());
        },
      );
      // Get.to(() => const VerifyOtp());
      // update();
    } else {
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
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future getUserData(BuildContext context) async {
    var response = await DataApiService.instance
        .post('/user-details', {}).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      userData = UserModel.fromJson(result['data']);
      userData!.accessToken = await getUserDataToken();
      userData!.tokenType = "Bearer";
      token.value = userData!.accessToken;
      homepageNumbers = [
        userData!.currentStreak,
        userData!.bestStreak,
        userData!.totalSessions,
        userData!.currentStreak
      ];
      print('save id is called');
      saveUserDataToken(token: token.value);
      setUserLoggedIn(true);
      // update();
      // Get.offAll(() => const SubscribeScreen());
    } else {
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future getSubscriptions(BuildContext context) async {
    var response = await DataApiService.instance
        .post('/subscriptions', {}).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      subscriptions.value = List<SubscriptionModel>.from(
          result['data'].map((x) => SubscriptionModel.fromJson(x)));
      print("subscriptions.length");
      print(subscriptions.length);
      // update();
      // Get.offAll(() => const SubscribeScreen());
    } else {
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future getCountries(BuildContext context) async {
    var response = await DataApiService.instance
        .post('/get_countries', {}).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      countries.value = List<CountryModel>.from(
          result['data'].map((x) => CountryModel.fromJson(x)));
      print("subscriptions.length");
      print(countries.length);
      // update();
      // Get.offAll(() => const SubscribeScreen());
    } else {
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future getCities(var body, BuildContext context) async {
    _baseController.showLoading('Loading cities...');
    var response = await DataApiService.instance
        .post('/get_cities', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      cities.value = List<CityModel>.from(
          result['data'].map((x) => CityModel.fromJson(x)));
      // update();
    } else {
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
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future logOut(BuildContext context) async {
    var response = await DataApiService.instance
        .post('/app-logout', {}).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(
            description: apiError["reason"], context: context);
      } else {
        _baseController.handleError(error, context);
      }
    });
    if (response == null) return;
    var result = json.decode(response);
    print(result);
    if (result['success']) {
      // update();
      // Get.offAll(() => const SubscribeScreen());
    } else {
      // CustomDialogBox.showErrorDialog(description: result["info"]);
    }
  }

  Future<void> signIn(BuildContext context) async {
    signOut();
    try {
      final googleUser = await _googleSignIn.signIn();
      print("googleUser");
      print(googleUser);
      if (googleUser != null) {
        _currentUser = googleUser;
        final googleAuth = await googleUser.authentication;
        print("check");
        print(googleAuth);
        await getFCMToken();
        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        print("credentials");
        print(credentials);
        if (credentials != null) {
          setUserType("Google");
          setUserLoggedIn(true);
          print('hello');
          print(_currentUser!.email.toString());
          Map<String, String> map = {
            "email": _currentUser!.email.toString(),
            "password": credentials.providerId.toString(),
            "provider": "google",
            "provider_id": credentials.providerId.toString(),
          };
          await getFCMToken();
          Platform.isIOS
              ? map.addAll({"ios_fcm_key": fcmToken.value})
              : map.addAll({"android_fcm_key": fcmToken.value});

          await userLogin(map, context);
          Get.offAll(() => const CommonNavigationBar(index: 0));
        } else {
          errorDialog(context, "Error", "Something went wrong");
          // QuickAlert.show(
          //   context: context,
          //   type: QuickAlertType.error,
          //   text: "Something went wrong",
          //   confirmBtnColor: Colors.black,
          //   confirmBtnTextStyle: textStyleBlackR.copyWith(color: Colors.white),
          //   onConfirmBtnTap: () {
          //     Get.back();
          //   },
          // );
        }
      }
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> signOut() async {
    print('I am google signing out');
    _googleSignIn.disconnect();
    setUserLoggedIn(false);
  }

  Future<void> appleSignUp(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.userIdentifier != null) {
        if (credential.email != null) {
          // userSignUp.name =
          // '${credential.givenName!} ${credential.familyName!}';
          // userSignUp.email = credential.email.toString();
          // userSignUp.password =
          // credential.userIdentifier.toString();
          // userSignUp.loginType = 'apple';
          Map<String, String> map = {
            "email": credential.email.toString(),
            "name": credential.givenName.toString(),
            "password": credential.userIdentifier.toString(),
          };
          var response = await DataApiService.instance
              .post('/signup', map)
              .catchError((error) {
            if (error is BadRequestException) {
              var apiError = json.decode(error.message!);
              CustomDialogBox.showErrorDialog(
                  description: apiError["message"], context: context);
            } else {
              _baseController.handleError(error, context);
            }
          });

          String result = await userLogin(map, context);
          if (result == 'true' ||
              result.contains(
                  "The email address is already in use by another account.")) {
            // var status = await AuthHelper.login(
            // Collections.USERS,
            // userSignUp.email,
            // userSignUp.password,
            // loginType: "apple",
            // );
            // if (status == "true") {
            // DataHelper.saveFcmToken(
            // Collections.FCM_TOKENS,
            // userData!.id,
            // )
          } else {
            errorDialog(context, "Error", "Something went wrong");
          }
        } else {
          errorDialog(
              context, "Error", "Apple sign-in was canceled or failed.");
        }
      } else {
        Map<String, String> map = {
          "email": credential.email.toString(),
          "name": credential.givenName.toString(),
          "password": credential.userIdentifier.toString(),
          "provider": "apple",
          "provider_id": credential.userIdentifier.toString(),
        };
        var response = await DataApiService.instance
            .post('/signup', map)
            .catchError((error) {
          if (error is BadRequestException) {
            var apiError = json.decode(error.message!);
            CustomDialogBox.showErrorDialog(
                description: apiError["message"], context: context);
          } else {
            _baseController.handleError(error, context);
          }
        });
        setUserType("Apple");
        await userLogin(map, context);
      }
    } catch (e) {
      errorDialog(context, "Error", "Apple sign-in was canceled or failed.");

      print('Error is $e');
    }
  }

// void handleError(error) {
//   hideLoading();
//   if (error is BadRequestException) {
//     var message = error.message;
//     CustomDialogBox.showErrorDialog(description: message);
//   } else if (error is FetchDataException) {
//     var message = error.message;
//     CustomDialogBox.showErrorDialog(description: message);
//   } else if (error is ApiNotRespondingException) {
//     CustomDialogBox.showErrorDialog(
//         description: 'Oops! It took longer to respond.');
//   }
// }
//
// showLoading([String? message]) {
//   CustomDialogBox.showLoading(message);
// }
//
// hideLoading() {
//   CustomDialogBox.hideLoading();
// }
}
