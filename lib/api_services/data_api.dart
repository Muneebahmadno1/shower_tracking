import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';
import 'api_exceptions.dart';
import 'api_urls.dart';

// This is the DataApiService class. It contains two methods, get and post, to access the api
// for both information retrieval and data updates. There is also a helper method named _processResponse
// which determines which response to send based on the response code received from the api.
class DataApiService {
  DataApiService._();

  // Stores timeout duration needed for api calls
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 9990;

  AuthController authController = Get.find();

  static final DataApiService _instance = DataApiService._();

  static DataApiService get instance => _instance;

  //GET
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(BASE_URL + api);
    try {
      var response = await http.get(uri, headers: {
        "Authorization": "Bearer ${authController.token.value}",
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String api, dynamic body) async {
    var uri = Uri.parse(BASE_URL + api);
    print("Url");
    print(uri.toString());
    print("Token");
    print(authController.token.value);
    print("Authorization: Bearer ${authController.token.value}");
    try {
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer ${authController.token.value}",
            },
            body: body,
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //MultiPartRequest
  Future<dynamic> multiPartPost(String api, String imageFile) async {
    var uri = Uri.parse(BASE_URL + api);
    try {
      var headers = {'Authorization': 'Bearer ${authController.token}'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://toocool.beckapps.co/api/update-profile'));
      request.files
          .add(await http.MultipartFile.fromPath('profile_image', imageFile));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request
          .send()
          .timeout(const Duration(seconds: TIME_OUT_DURATION));

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return response.statusCode.toString();
      } else {
        print(response.reasonPhrase);
        return response.statusCode.toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }

    // // open a bytestream
    // var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // // get file length
    // var length = await imageFile.length();
    //
    // // string to uri
    // var uri = Uri.parse("$BASE_URL+$api");
    //
    // Map<String, String> headers = {
    //   "Authorization": "Bearer ${authController.token.value}"
    // };
    //
    // // create multipart request
    // var request = http.MultipartRequest("POST", uri);
    //
    // // multipart that takes file
    // var multipartFile = http.MultipartFile('profile_image', stream, length,
    //     filename: basename(imageFile.path));
    //
    // // add file to multipart
    // request.headers.addAll(headers);
    // request.files.add(multipartFile);
    //
    // // send
    // var response = await request.send();
    // print(response.statusCode);
    // print(response.reasonPhrase);
    //
    // // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
  }

  // Helper method that determines response based on response code
  dynamic _processResponse(http.Response response) {
    var responseJson = utf8.decode(response.bodyBytes);
    debugPrint('responseJson');
    debugPrint(responseJson);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
