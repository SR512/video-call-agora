class VerifyOtp {
  late bool error;
  late User? user;
  late String message;

  VerifyOtp({required this.error, this.user, required this.message});

  VerifyOtp.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['error'] = this.error;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? mobile;
  String? profile;
  String? appToken;
  String? rtcToken;
  String? fcmToken;

  User(
      {this.name,
        this.email,
        this.mobile,
        this.profile,
        this.appToken,
        this.rtcToken,this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    profile = json['profile'];
    appToken = json['app_token'];
    rtcToken = json['rtc_token'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['profile'] = profile;
    data['app_token'] = appToken;
    data['rtc_token'] = rtcToken;
    data['fcmToken'] = fcmToken;
    return data;
  }
}