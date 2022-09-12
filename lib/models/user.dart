import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String university;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.university,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'university': university,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : firstName = doc.data()?['first_name'] ?? '',
        lastName = doc.data()?['last_name'] ?? '',
        email = doc.data()?['email'] ?? '',
        university = doc.data()?['university'] ?? '';
}
