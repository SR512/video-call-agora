import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../utils/api_client.dart';

class LoginController extends GetxController {

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  var mobileNumber = '';
  var isLoading = true.obs;

  void sendOtp() async {
    try {
      var response = await ApiClient().login({'mobile':mobileNumber.replaceAll('+91','')});
      if(!response.error){
        isLoading.value = false;
        update();
        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
        Get.offNamed('verify-otp');
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