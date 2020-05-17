import 'package:chatapp/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chat",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        // This will give us a different stream whenever: we log in, we log out
        // the whole token story is handled here.
        stream: FirebaseAuth.instance.onAuthStateChanged,
        // the usersnaphot contains the token.
        // if the usersnaphot has a valid token, open chat screen.
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return Chat_Screen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
