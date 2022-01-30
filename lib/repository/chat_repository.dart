import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';

class ChatRepository {

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  // userIdを取得
  final String userId = AuthRepository().signInUser!.uid;

  Future createMessage(String messageText, String uid, String createdAt) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .set({
      'text': messageText,
      'email': uid,
      'date': createdAt
    });
  }

  callMessage() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots();
  }

  deleteMessage(String docId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(docId)
        .delete();
  }
}