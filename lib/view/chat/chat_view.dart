import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/main.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';
import 'package:flutter_with_firebase/repository/chat_repository.dart';
import 'package:flutter_with_firebase/view/chat/chat_view_model.dart';
import 'package:flutter_with_firebase/view/chat/input/chat_input_view.dart';
import 'package:flutter_with_firebase/view/signin/signin_view.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>.value(
      value: ChatViewModel()..init(),
      child: Consumer<ChatViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ChatApp'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  AuthRepository().logoutUser();
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const SignInView();
                      })
                  );
                },
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('ログイン情報${model.memberInfo.uid}'),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ChatRepository().callMessage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents = snapshot.data!.docs;
                        return ListView(
                          children: documents.map((document) {
                            return Card(
                              child: ListTile(
                                  title: Text(document['text']),
                                  subtitle: Text(document[('uid')]),
                                  trailing: document['uid'] == model.memberInfo.uid
                                  ? IconButton(
                                  icon: const Icon(Icons.delete),
                              onPressed: () async {
                                ChatRepository().deleteMessage(document.id);
                              },
                            ) : null,
                            ),
                            );
                          }).toList(),
                        );
                      }
                      return const Center(
                        child: Text('読込中...'),
                      );
                    },
                  )
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const ChatInputView();
                  })
              );
            },
          ),
        );
      }),
    );
  }
}