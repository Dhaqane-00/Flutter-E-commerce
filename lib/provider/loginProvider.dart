import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/models/UserUpdate.dart';
import 'package:shop_app/server/UpdateUser.dart';
import '../models/user.dart';
import '../server/GetUser.dart';
import '../server/UserLogin.dart';
import 'dart:io';

enum LoginState { normal, loading, error, networkError, success }

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  LoginState loginState = LoginState.normal;
  LoginState _updateState = LoginState.normal; // Private variable for update state
  final box = GetStorage();
  final UpdateUserService updateUserService = UpdateUserService(); // Instance of UpdateUserService

  UserProvider() {
    if (box.read('isLoggedIn') ?? false) {
      user = UserModel.fromJson(box.read('user') ?? {});
      fetchUserById(user.id!); // Fetch user data on initialization
    }
  }

  bool get isLoggedIn => box.read('isLoggedIn') ?? false;

  String? get userId => user.id;

  String? get userName => user.email;

  LoginState get updateState => _updateState; // Getter for updateState

  Future<void> fetchUserById(String id) async {
    try {
      final fetchedUser = await GetUserService().fetchUserById(id);
      if (fetchedUser != null) {
        user = UserModel.fromJson(fetchedUser as Map<String, dynamic>);
        box.write('user', user.toJson());
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

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

  Future<void> updateUser({
    required String name,
    required String address,
  }) async {
    try {
      _updateState = LoginState.loading; // Set updateState to loading
      notifyListeners();
      UserUpdate updatedUser = await updateUserService.updateUser(
        userId: user.id!,
        name: name,
        address: address,
      );

      // Convert UserUpdate to UserModel
      user = UserModel(
        id: updatedUser.id,
        name: user.name,
        email: user.email,
        address: updatedUser.address,
        photo: updatedUser.photo,
        // Add other fields from UserModel as necessary
      );

      box.write('user', user.toJson());
      _updateState = LoginState.success; // Set updateState to success
      notifyListeners();
    } catch (e) {
      _updateState = LoginState.error; // Set updateState to error
      notifyListeners();
      throw e;
    }
  }

  Future<void> updateProfilePicture(File photo) async {
    try {
      _updateState = LoginState.loading;
      notifyListeners();
      UserUpdate updatedUser = await updateUserService.updateUser(
        userId: user.id!,
        photo: photo,
      );

      // Convert UserUpdate to UserModel
      user = UserModel(
        id: updatedUser.id,
        name: user.name,
        email: user.email,
        address: user.address,
        photo: updatedUser.photo,
        // Add other fields from UserModel as necessary
      );

      box.write('user', user.toJson());
      _updateState = LoginState.success;
      notifyListeners();
    } catch (e) {
      _updateState = LoginState.error;
      notifyListeners();
      throw e;
    }
  }
}
