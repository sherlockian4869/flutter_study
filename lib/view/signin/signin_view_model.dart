import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';

class SigninViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String messageText = '';

  Future<UserCredential?> signUp() async {
    return await AuthRepository().createUser(emailController.text, passwordController.text);
  }
}