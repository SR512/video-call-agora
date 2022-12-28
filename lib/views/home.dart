import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_call/controllers/home_controller.dart';

import '../utils/api_client.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {

  final homeController = Get.isRegistered<HomeController>() ? Get.find<HomeController>():Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      //print('Event data :- ${event.data['body']}');
      if(event.data['body'] != null){
        homeController.showCallkitIncoming(event.data['body']);
      }
      Get.snackbar("Success",snackPosition: SnackPosition.BOTTOM,"Body ${event.notification!.body}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

      FlutterCallkitIncoming.onEvent.listen((event) {
      switch (event?.event.name) {
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_INCOMING':
        // TODO: received an incoming call
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_START':
        // TODO: started an outgoing call
        // TODO: show screen calling in Flutter
          Get.snackbar("ACTION_CALL_START",snackPosition: SnackPosition.BOTTOM,"ACTION_CALL_START");
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_ACCEPT':
        // TODO: accepted an incoming call
        // TODO: show screen calling in Flutter
          //Get.snackbar("ACTION_CALL_ACCEPT",snackPosition: SnackPosition.BOTTOM,"ACTION_CALL_ACCEPT");
          Get.offNamed('video-screen');
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_DECLINE':
        // TODO: declined an incoming call
          homeController.channelName.value = "";
          // Get.snackbar("ACTION_CALL_DECLINE",snackPosition: SnackPosition.BOTTOM,"ACTION_CALL_DECLINE");
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_ENDED':
          Get.snackbar("ACTION_CALL_ENDED",snackPosition: SnackPosition.BOTTOM,"ACTION_CALL_ENDED");
        // TODO: ended an incoming/outgoing call
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TIMEOUT':
        // TODO: missed an incoming call
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_CALLBACK':
        // TODO: only Android - click action `Call back` from missed call notification
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TOGGLE_HOLD':
        // TODO: only iOS
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TOGGLE_MUTE':
        // TODO: only iOS
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TOGGLE_DMTF':
        // TODO: only iOS
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TOGGLE_GROUP':
        // TODO: only iOS
          break;
        case 'com.hiennv.flutter_callkit_incoming.ACTION_CALL_TOGGLE_AUDIO_SESSION':
        // TODO: only iOS
          break;
        case  'com.hiennv.flutter_callkit_incoming.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP':
        // TODO: only iOS
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              homeController.isLoading.value = true;
              homeController.getContactList();
            },
          )
        ],
      ),
      body: Obx(() =>
        homeController.isLoading.value ?
        Center(child: CircularProgressIndicator()):
           ListView.builder(
              itemCount: homeController.callerInfoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(homeController.callerInfoList[index].name.toString()),
                    leading: CircleAvatar(
                        child: Image.network(
                            homeController.callerInfoList[index].profile.toString())),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.call,
                          ),
                          iconSize: 30,
                          color: Colors.black,
                          splashColor: Colors.purple,
                          onPressed: () async {
                            homeController.channelName.value  = homeController.callerInfoList[index].name.toString();
                            homeController.type.value  ='audio';
                            final Map<String, dynamic> params = <String, dynamic>{
                              "type":'audio',
                              "id":homeController.callerInfoList[index].appToken.toString(),
                              "channel":homeController.callerInfoList[index].name.toString(),
                              "profile": homeController.callerInfoList[index].profile.toString(),
                              "name": homeController.callerInfoList[index].name.toString(),
                              "number": homeController.callerInfoList[index].mobile.toString(),
                            };
                            //await ApiClient().sendMessage(homeController.callerInfoList[index].fcmToken.toString(),jsonEncode(params));
                            //Get.offNamed('video-screen');
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.video_call,
                          ),
                          iconSize: 30,
                          color: Colors.black,
                          splashColor: Colors.purple,
                          onPressed: () async{
                            homeController.channelName.value  = homeController.callerInfoList[index].name.toString();
                            homeController.type.value  ='video';
                            final Map<String, dynamic> params = <String, dynamic>{
                              "type":'video',
                              "id":homeController.callerInfoList[index].appToken.toString(),
                              "channel":homeController.callerInfoList[index].name.toString(),
                              "profile": homeController.callerInfoList[index].profile.toString(),
                              "name": homeController.callerInfoList[index].name.toString(),
                              "number": homeController.callerInfoList[index].mobile.toString(),
                            };
                            await ApiClient().sendMessage(homeController.callerInfoList[index].fcmToken.toString(),jsonEncode(params));
                            Get.offNamed('video-screen');
                          },
                        )
                      ],
                    ),
                  ),
                );
              })
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed:() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Get.offNamed('login');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.logout),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
