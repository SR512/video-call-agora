class Contact {
  late bool error;
  late List<User>? user;
  late String message;

  Contact({required this.error, this.user, required this.message});

  Contact.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = error;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
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