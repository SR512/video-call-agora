import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Contact.dart';
import '../utils/api_client.dart';

class HomeController extends GetxController {

  List<User> callerInfoList = <User>[].obs;
  var isLoading = true.obs;
  RxString channelName = "".obs;
  RxString type = "video".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getContactList();
  }

  Future<void> getContactList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userdata = prefs.getString('user');
      Map<String, dynamic> map = jsonDecode(userdata!);

      var response = await ApiClient().contactList(map['app_token']);

      if (!response.error) {
        callerInfoList = response.user!.toList();
        isLoading.value = false;
        update();
        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
      } else {
        Get.snackbar("Error",snackPosition: SnackPosition.BOTTOM,response.message);
      }
    } catch (e) {
      Get.snackbar("Error",snackPosition: SnackPosition.BOTTOM,e.toString());
    }
  }

  Future<void> showCallkitIncoming(String data) async {
    Map<String, dynamic> userInfo = jsonDecode(data!);
    channelName.value = userInfo['channel'];
    type.value = userInfo['type'];

    final params = CallKitParams(
      id: userInfo['id'],
      nameCaller: userInfo['name'],
      appName: 'Callkit',
      avatar: userInfo['profile'],
      handle: userInfo['number'],
      type: 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: 'Call back',
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        isShowCallback: true,
        isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

}