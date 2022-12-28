import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_call/src/constants/config.dart';

import '../models/AccessToken.dart';
import '../models/Contact.dart';
import '../models/SendOtp.dart';
import '../models/VerifyOtp.dart';


class ApiClient {
  String? _token;

  Future<SendOtp> login(data) async {
    print(data);
    final response = await http.post(Uri.parse("$baseUrl/login"),
        body: jsonEncode(data), headers: _setHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      return SendOtp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<VerifyOtp> verifyOtp(data) async {
    print(data);
    final response = await http.post(Uri.parse("$baseUrl/verify-otp"),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      return VerifyOtp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<Contact> contactList(token) async {
    _token = token;
    print(_token);
    final response = await http.get(Uri.parse("$baseUrl/contact-list"),
        headers: _setHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<AccessToken> accessToken(channelName, token) async {
    _token = token;
    print(channelName);
    final response = await http.get(
        Uri.parse("$baseUrl/generate-agora-token/" + channelName),
        headers: _setHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future sendMessage(String token, String body) async {
    try {
      final response = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: <String, String>{
                'Content-type': 'application/json',
                'Authorization':
                'key=$AuthorizationKey'
              },
              body: jsonEncode(<String, dynamic>{
                "priority": "High",
                "data": <String, dynamic>{
                  'click_action': '',
                  'status': 'done',
                  'body': body,
                  'title': "Calling..",
                },
                "to": token,
              }));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('error push notification.!');
    }
  }

  // Future<RegisterDeviceInfo> registerDeviceInfo(url, data,token) async {
  //   _token = token;
  //   final response = await http.post(Uri.parse("${baseUrl}register-device-info"),
  //       body: jsonEncode(data), headers: _setHeaders());
  //   print(response.body);
  //   print(data);
  //   if (response.statusCode == 200) {
  //     return RegisterDeviceInfo.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to get data');
  //   }
  // }

  // Future<RegisterDevice> registerDevice(url, data,token) async {
  //   _token = token;
  //   final response = await http.post(Uri.parse("${baseUrl}register-device"),
  //       body: jsonEncode(data), headers: _setHeaders());
  //   print(response.body);
  //   print(data);
  //   if (response.statusCode == 200) {
  //     return RegisterDevice.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to get data');
  //   }
  // }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      };
}
