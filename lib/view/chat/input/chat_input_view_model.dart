import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ChatInputViewModel extends ChangeNotifier {

  final date = DateTime.now().toLocal().toIso8601String();
  final TextEditingController messageController = TextEditingController();

  final String userId = AuthRepository().signInUser!.uid;

}