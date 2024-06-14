import 'dart:io';
import 'package:chat_app/firebase_services/authServices/authGate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: Platform.isAndroid
          ? FirebaseOptions(
              apiKey: 'AIzaSyAz_xVUEhudbTk-6TAejsNoay_XIulrdtw',
              appId: "1:430002364211:android:a3a4a80a3ae3677acca846",
              messagingSenderId: "430002364211",
              projectId: "chatapp-1-75dc4",
              storageBucket: "chatapp-1-75dc4.appspot.com")
          : FirebaseOptions(
              apiKey: 'AIzaSyCa2sG8Ss-Dwi4MGbYeWhPHYueQkce_V8o',
              appId: '1:430002364211:ios:038a80bc733b600cca846',
              messagingSenderId: '430002364211',
              projectId: 'chatapp-1-75dc4',
              storageBucket: 'chatapp-1-75dc4.appspot.com'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Authgate(),
    );
  }
}
