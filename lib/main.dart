import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_call/utils/theme/them.dart';
import 'package:video_call/views/auth/login.dart';
import 'package:video_call/views/auth/verify-otp.dart';
import 'package:video_call/views/home.dart';
import 'package:video_call/views/splash_screen.dart';
import 'package:video_call/views/video_call_screen.dart';

import 'controllers/home_controller.dart';
import 'firebase_options.dart';
bool isLogin = false;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(HomeController());
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  runApp(const MyApp());
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  if(message.data['body'] != null){
    Get.put(HomeController());
    Get.find<HomeController>().showCallkitIncoming(message.data['body']);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final homeController = Get.isRegistered<HomeController>() ? Get.find<HomeController>():Get.put(HomeController());

    return GetMaterialApp(
      title: 'Video call',
      theme:CustomAppTheme.lightTheme,
      darkTheme:CustomAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      getPages: [
        GetPage(name: "/splash-screen", page:() => const SplashScreen()),
        GetPage(name: "/login", page:() => const Login()),
        GetPage(name: "/verify-otp", page:() => const VerifyOtp()),
        GetPage(name: "/home", page:() => const Home()),
        GetPage(name: "/video-screen", page:() =>  VideoCallScreen())
      ],
      initialRoute:homeController.channelName.isNotEmpty ?'/video-screen':'/splash-screen',
    );
  }
}
