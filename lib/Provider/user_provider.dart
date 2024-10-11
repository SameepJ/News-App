import 'package:flutter/material.dart';
import '../Model/user_model.dart';
// import '../UI/auth/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/firebase_repo.dart';
class UserProvider with ChangeNotifier {
  final FirebaseRepo _firebaseRepo = FirebaseRepo();

  Future<void> signup(UserModel user) async {
    await _firebaseRepo.storeUser(user);
    notifyListeners(); // Notify listeners after updating the user
  }
}
