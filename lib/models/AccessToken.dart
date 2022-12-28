class AccessToken {
  late bool error;
  late Data? data;
  late String message;

  AccessToken({required this.error, this.data, required this.message});

  AccessToken.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? rtcToken;
  String? rtmToken;

  Data({this.rtcToken, this.rtmToken});

  Data.fromJson(Map<String, dynamic> json) {
    rtcToken = json['rtc_token'];
    rtmToken = json['rtm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rtc_token'] = rtcToken;
    data['rtm_token'] = rtmToken;
    return data;
  }
}