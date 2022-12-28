import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_client.dart';

class VerifyOtpController extends GetxController {

  var otp = '';
  var fcm_token = '';
  var mobile = '';
  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    FirebaseMessaging.instance.getToken().then((token) => {
      fcm_token = token!
    });
  }

  void submitOtp() async {
    try {
      var response = await ApiClient().verifyOtp({'otp':otp,'mobile':mobile.replaceAll('+91',''),'fcm_token':fcm_token});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(response);
      if(!response.error){
        prefs.clear();
        prefs.setBool('isLogin',true);
        prefs.setString('user', jsonEncode(response.user));
        isLoading.value = false;
        update();
        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
        Get.offNamed('home');

      }else{
        isLoading.value = false;
        update();
        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
      }

    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,e.toString());
    }
  }
}