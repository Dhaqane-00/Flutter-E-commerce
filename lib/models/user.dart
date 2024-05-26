
class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? photo;
  String? role;
  int? version;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.role,
    this.version,
    this.token,
  });

  // Factory constructor to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      photo: json['photo'],
      role: json['role'],
      version: json['__v'],
      token: json['token'],
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'photo': photo,
      'role': role,
      '__v': version,
      'token': token,
    };
  }
}