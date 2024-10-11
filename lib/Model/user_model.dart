import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;  // Firestore document ID
  String name;
  String email;

  UserModel({
    this.id,
    required this.name,
    required this.email,
  });

  // Convert UserModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  // Create UserModel from Firestore document snapshot
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
    );
  }

  // Create UserModel from Firestore map (in case you get a map instead of DocumentSnapshot)
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
