import 'package:flutter/material.dart';
import 'package:lingopandasameepjain/Model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/firebase_repo.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseRepo _firebaseRepo = FirebaseRepo();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseRepo.login(email, password);
      // Optionally, you can perform additional actions after successful login, such as fetching user data.

      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString(); // Set the error message
    }
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      User? myUser = await _firebaseRepo.signup(name, email, password);
      UserModel user= UserModel(email: email, name:  name, id: myUser!.uid);
      await _firebaseRepo.storeUser(user);

      _errorMessage = null;
    } catch (error) {
      _errorMessage = error.toString();
    }
    notifyListeners();
  }
}
