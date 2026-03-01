import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_client.dart'; 

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // 呼叫 ApiClient 的靜態方法
    final response = await ApiClient.login(email, password);

    if (response['status'] == 'success') {
      final userData = response['data'];
      _currentUser = User(
        id: userData['id'],
        email: userData['email'],
        firstName: userData['firstName'],
        lastName: userData['lastName'],
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true; 
    } else {
      _error = response['message'];
      _isLoading = false;
      _isAuthenticated = false;
      notifyListeners();
      return false; 
    }
  }

  void signup(String email, String firstName, String lastName, String password) {
    _isLoading = true;
    _error = null;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        firstName: firstName,
        lastName: lastName,
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
    });
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}