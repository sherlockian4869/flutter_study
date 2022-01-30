import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/repository/chat_repository.dart';
import 'package:flutter_with_firebase/view/chat/input/chat_input_view_model.dart';
import 'package:provider/provider.dart';

class ChatInputView extends StatelessWidget {
  const ChatInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatInputViewModel>(
        create: (_) => ChatInputViewModel(),
      child: Consumer<ChatInputViewModel>(builder: (context, model, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('入力画面'),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: model.messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: '投稿メッセージ'),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('投稿'),
                      onPressed: () async {
                        ChatRepository().createMessage(model.messageController.text, model.userId, model.date);
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
