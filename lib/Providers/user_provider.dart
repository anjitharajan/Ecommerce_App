import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

//------- Get current user -------\\
  User? get user => _authService.currentUser;

//------- Login user -------\\
  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    //------- Notify listeners about user state change -------\\
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    await _authService.signup(email, password);
    notifyListeners();
  }

//------- Logout user -------\\
  Future<void> logout() async {
    await _authService.logout();
    notifyListeners();
  }
}
