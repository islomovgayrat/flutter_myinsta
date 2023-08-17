class Member {
  String? uId = '';
  String fullName = '';
  String email = '';
  String password = '';
  String imgUrl = '';

  String deviceId = '';
  String deviceType = '';
  String deviceToken = '';

  Member(this.fullName, this.email);

  Member.fromJson(Map<String, dynamic> json)
      : uId = json['uId'],
        fullName = json['fullName'],
        email = json['email'],
        password = json['password'],
        imgUrl = json['imgUrl'],
        deviceId = json['deviceId'],
        deviceType = json['deviceType'],
        deviceToken = json['deviceToken'];

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'fullName': fullName,
        'email': email,
        'password': password,
        'imgUrl': imgUrl,
        'deviceId': deviceId,
        'deviceType': deviceType,
        'deviceToken': deviceToken,
      };
}
