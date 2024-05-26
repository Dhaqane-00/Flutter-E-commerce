import 'package:meta/meta.dart';

class UserSignUpModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? photo;
  String? role;
  bool? verify;
  int? v;
  String? token;

  UserSignUpModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.role,
    this.verify,
    this.v,
    this.token,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      photo: json['photo'] as String?,
      role: json['role'] as String?,
      verify: json['verify'] as bool?,
      v: json['__v'] as int?,
      token: json['token'] as String?,
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
      'verify': verify,
      '__v': v,
      'token': token,
    };
  }
}
