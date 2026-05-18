import 'package:backend/future_builder/auth_service/auth_serive_class.dart';
import 'package:flutter/material.dart';

class Auth_Provider extends ChangeNotifier {
  AuthSeriveClass service = AuthSeriveClass();
  Future<void> signup(
    String email,
    String password,
    String name,
    String address,
    String phone,
  ) async {
    await service.signup(email, password, name, address, phone);
  }

  Future<void> signin(String email, String password) async {
    await service.signin(email, password);
  }

  Future<void> logout() async {
    await service.logout();
  }
}
