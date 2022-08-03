import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kortobaa/helpers/http_exception.dart';

class AuthProvider with ChangeNotifier {
  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomHttpException(
        e.code.toString(),
      );
    }
  }

  Future signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(firstName + " " + lastName);
    } on FirebaseAuthException catch (e) {
      throw CustomHttpException(
        e.code.toString(),
      );
    }
  }
}
