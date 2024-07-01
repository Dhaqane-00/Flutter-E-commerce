class UserUpdate {
  String? id;
  String? name;
  String? email;
  String? password;
  String? photo;
  String? role;
  String? address;
  int? version;
  String? token;
  bool verify;
  String? otp;
  String? otpExpires;

  UserUpdate({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.role,
    this.address,
    this.version,
    this.token,
    this.verify = false,
    this.otp,
    this.otpExpires,
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      photo: json['photo'],
      role: json['role'],
      address: json['address'],
      version: json['__v'],
      token: json['token'],
      verify: json['verify'] ?? false,
      otp: json['otp'],
      otpExpires: json['otpExpires'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'photo': photo,
      'role': role,
      'address': address,
      '__v': version,
      'token': token,
      'verify': verify,
      'otp': otp,
      'otpExpires': otpExpires,
    };
  }
}