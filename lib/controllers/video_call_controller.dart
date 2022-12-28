import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_call/controllers/home_controller.dart';
import 'package:video_call/src/constants/config.dart';
import '../utils/api_client.dart';

class VideoCallController extends GetxController {
  var tempToken = "".obs;
  var isLoading = true.obs;
  late  AgoraClient client;
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initEngine(homeController.channelName.value);
  }

  Future<void> _initEngine(channelName) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userdata = prefs.getString('user');
      Map<String, dynamic> map = jsonDecode(userdata!);

      var response = await ApiClient().accessToken(channelName, map['app_token']);

      if (!response.error) {
        tempToken.value = response.data!.rtcToken.toString();

        if(homeController.type.value == 'video'){

          client = AgoraClient(
              agoraConnectionData: AgoraConnectionData(appId:appId, channelName:channelName,tempToken: tempToken.value),
              enabledPermission: [Permission.camera, Permission.microphone],
              agoraEventHandlers: AgoraRtcEventHandlers(
                leaveChannel: (state){
                  homeController.channelName.value = '';
                  client.engine.destroy();
                  Get.offNamed('home');
                },
              )
          );
        }
        await client.initialize();

        isLoading.value = false;
        update();

        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
      }else{
        Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,response.message);
      }
    } catch (e) {
      Get.offNamed('home');
      Get.snackbar(
          "Error 1", snackPosition: SnackPosition.BOTTOM, e.toString());
    }
  }

}
