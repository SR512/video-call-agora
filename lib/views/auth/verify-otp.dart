import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/controllers/login_controller.dart';
import 'package:video_call/controllers/verify_otp_controller.dart';
import 'package:video_call/src/constants/config.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  final loginController = Get.find<LoginController>();
  final verifyOtpController = Get.put(VerifyOtpController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('Verify OTP',style:Theme.of(context).textTheme.headline1,textAlign: TextAlign.center),
            Text('Code is sent to ${loginController.mobileNumber}',style:Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center),
            SizedBox(height: size.height * 0.02),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              cursorColor: Colors.black,
              onSubmit:(code){
                verifyOtpController.mobile = loginController.mobileNumber;
                verifyOtpController.otp = code;
                verifyOtpController.submitOtp();
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

