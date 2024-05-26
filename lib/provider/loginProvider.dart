import 'package:shop_app/models/user.dart';
import 'package:shop_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../server/UserLogin.dart';

enum LoginState { normal, loading, error, networkError, success }

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  LoginState loginState = LoginState.normal;
  final box = GetStorage();
  login({required String email,required String password,Function(UserModel)? onSuccess,Function(String)? onError,}) async {
    try {
      loginState = LoginState.loading;
      notifyListeners();
      user = await UserServices().login(email: email, password: password);
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
}
