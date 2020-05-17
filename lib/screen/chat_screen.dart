import 'package:chatapp/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/chat/messages.dart';
import 'package:chatapp/chat/new_messages.dart';

class Chat_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: <Widget>[
          DropdownButton(
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logoutID") {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                //The value serves as Itendifier.
                value: "logoutID",
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                    ),
                    SizedBox(width: 8),
                    Text("Log Out")
                  ],
                )),
              )
            ],
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            New_Messages(),
          ],
        ),
      ),
    );
  }
}
