import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/controllers/video_call_controller.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final videocallController = Get.put(VideoCallController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videocallController.client.engine.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Obx(() => videocallController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    AgoraVideoViewer(client: videocallController.client,enableHostControls: true),
                    AgoraVideoButtons(client: videocallController.client),
                  ],
                )),
        ),
      ),
    );
  }
}
