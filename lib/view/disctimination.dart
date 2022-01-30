import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';
import 'package:flutter_with_firebase/view/chat/chat_view.dart';
import 'package:flutter_with_firebase/view/signin/signin_view.dart';
import '';

class DiscriminationPage extends StatelessWidget {
  const DiscriminationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AuthRepository().signInUser != null) {
      return const ChatView();
    } else {
      return const SignInView();
    }
  }
}
