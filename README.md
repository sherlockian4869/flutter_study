# flutter学習日記

1. チャットアプリ作成  
    1. Firebase連携
    1. 状態管理

__1月10日__  
下記資料をもとにチャットアプリを作成  
(Firebaseを使ったアプリ概要)[https://www.flutter-study.dev/firebase-app/about-firebase-app]  
- チャットアプリの土台の作成
- Firebase連携
- 状態管理の学習(provider)
- 状態管理の学習(RiverPods)

__1月12日__  
状態管理について学習
- provider
- Firebaseで取得したデータと状態管理の連携
- MVVMモデルを使用してファイル分けも同時に行った

問題点  
- Firebase_Authには登録ができても次の画面に遷移できない
    - Authからの戻り値または登録成功に戻り値が取得できていない
