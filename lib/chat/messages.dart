import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        return StreamBuilder(
          // We tap into the chat collection and listen to it with Snapshot
          stream: Firestore.instance
              .collection("chat")
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (ctx, chatsnapShot) {
            if (chatsnapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final chatDocs = chatsnapShot.data.documents;

            return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) {
                  return Message_bubble(
                    chatDocs[index]["text"],
                    // We forward username
                    chatDocs[index]["username"],
                    chatDocs[index]["userImage"],
                    // Check if the loged in userid is the same as the message user id.
                    chatDocs[index]["userId"] == futureSnapshot.data.uid,
                    // We add a key for efficiency
                    key: ValueKey(chatDocs[index].documentID),
                  );
                });
          },
        );
      },
    );
  }
}
