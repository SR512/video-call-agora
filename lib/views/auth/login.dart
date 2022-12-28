import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:video_call/controllers/login_controller.dart';
import 'package:video_call/src/constants/config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back",
                  style: Theme.of(context).textTheme.headline1),
              Text("You`ll receive a 6 digit code to verify next",
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: size.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        loginController.mobileNumber = number.phoneNumber!;
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      cursorColor: Colors.black,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: loginController.number,
                      textFieldController: loginController.controller,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Mobile number',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    loginController.sendOtp();
                  },
                  child: Text('Request OTP',
                      style: Theme.of(context).textTheme.button),
                ),
              )
            ],
          ),
        )), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
