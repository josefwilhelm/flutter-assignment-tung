import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment/models/user.dart';

import 'base_service.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService extends BaseService {
  saveUser(User user) async {
    fireStoreInstance
        .collection("users")
        .document(user.id)
        .setData(user.toJson());
  }

  Future<User> getUser(FirebaseUser user) async {
    final doc =
        await fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }
}
