import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/repository/auth_repository.dart';
import 'package:flutter_with_firebase/view/chat/chat_view.dart';
import 'package:flutter_with_firebase/view/signin/signin_view_model.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninViewModel(),
      child: Consumer<SigninViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // メールアドレス入力
                    TextFormField(
                      decoration: InputDecoration(labelText: 'メールアドレス'),
                      controller: model.emailController,
                    ),
                    //  パスワード入力
                    TextFormField(
                      decoration: InputDecoration(labelText: 'パスワード'),
                      controller: model.passwordController,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(model.messageText),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text('ユーザ登録'),
                        onPressed: () async {
                          try {
                            final result = model.signUp();
                            if (result == null) {
                              return;
                            }
                            await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return ChatView();
                                })
                            );
                          } catch (e) {
                            model.messageText = '登録に失敗しました。';
                          }
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          try {
                            // メール・パスワードでログイン
                            final email = model.emailController.text;
                            final password = model.passwordController.text;
                            final result = AuthRepository().loginUser(email, password);

                            await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return const ChatView();
                                })
                            );
                          } catch (e) {
                            model.messageText = '認証に失敗しました。';
                          }
                        },
                        child: const Text('ログイン'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
