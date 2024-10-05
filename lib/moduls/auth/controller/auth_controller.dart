import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/api_manager.dart';
import '../../../res/api_model.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/local_storage.dart';

class AuthController extends GetxController{
  RxBool agreePrivacyCheck = false.obs,
      isRegisterPassVisible = true.obs,
      isRegisterCfnPassVisible = true.obs,
      isResetPassVisible = true.obs,
      isResetCfnPassVisible = true.obs;

  final APIManager _apiManager = APIManager.apiManagerInstanace;
  // final APIS _apis = APIS.apisSharedInstanace;
  final LocalStorage _localStorage = LocalStorage.localStorageSharedInstance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  //Login User
  Future<void> loginUserMethod(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/auth/login',
      Method.post,
      param,
    );
    log("Login API Response -----> ${apiResponse.data}");
    log("Login API Response -----> ${apiResponse.status}");
    log("Login API Response -----> ${apiResponse.error}");
    if (apiResponse.status) {
      Get.back();

      await _localStorage.setBoolValue(_localStorage.login, true);

      await _localStorage.setValue(
          _localStorage.token, apiResponse.data['token'].toString());

      // Get.offAllNamed(RouteName.dashboardScreen);
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error!.description);
    }
  }
}