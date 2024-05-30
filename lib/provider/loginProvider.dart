import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../server/UserLogin.dart';
import '../models/user.dart';

enum LoginState { normal, loading, error, networkError, success }

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  LoginState loginState = LoginState.normal;
  final box = GetStorage();

  UserProvider() {
    if (box.read('isLoggedIn') ?? false) {
      user = UserModel.fromJson(box.read('user') ?? {});
    }
  }

  bool get isLoggedIn => box.read('isLoggedIn') ?? false;

  String? get userId => user.id;

  String? get userName => user.email; // Getter method to retrieve user ID

  Future<void> login({
    required String email,
    required String password,
    Function(UserModel)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      loginState = LoginState.loading;
      notifyListeners();
      user = await UserServices().login(email: email, password: password);
      box.write('isLoggedIn', true);
      box.write('user', user.toJson());
      loginState = LoginState.success;
      notifyListeners();
      if (onSuccess != null) {
        onSuccess(user);
      }
    } catch (e) {
      loginState = LoginState.error;
      notifyListeners();
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  Future<void> logout() async {
    box.write('isLoggedIn', false);
    box.remove('user');
    loginState = LoginState.normal;
    notifyListeners();
  }
}
