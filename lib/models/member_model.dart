class Member {
  String? uId = '';
  String fullName = '';
  String email = '';

  Member(this.fullName, this.email);

  Member.fromJson(Map<String, dynamic> json)
      : uId = json['uId'],
        fullName = json['fullName'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'fullName': fullName,
        'email': email,
      };
}
