import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ログイン中のFirebaseUserを返す
  User? get signInUser => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;
  bool get isNotSignedIn => _auth.currentUser == null;

  Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
  Future<UserCredential?>  createUser(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      throw MyAuthException(
        e.code,
        _convertErrorMessage(e.code)
      );
    }
  }
  Future<UserCredential?> loginUser(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result;
  }

  String _convertErrorMessage(String errorMessage) {
    switch (errorMessage) {
      case 'weak-password':
      return '安全なパスワードではありません';
      case 'email-already-in-use':
      return 'すでに使われているメールアドレスです';
      case 'invalid-email':
      return 'メールアドレスを正しい形式で入力してください';
      case 'operation-not-allowed':
      return '登録が許可されていません';
      case 'wrong-password':
      return 'パスワードが間違っています';
      case 'user-not-found':
      return 'ユーザーが見つかりません';
      case 'user-disabled':
      return 'ユーザーが無効です';
      default:
      return '不明なエラーです';
    }
  }
}

class MyAuthException implements Exception {
  MyAuthException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}