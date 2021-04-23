import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testc/src/widgets/chat_message_other.dart';
import 'package:testc/src/widgets/mychat_other.dart';
import 'chat_message_other.dart';
//import 'chat_message.dart';
import 'mychat.dart';

class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;
  final ValueChanged<String> onDelete;
  const MessageWall({
    Key key,
    this.messages,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final data = messages[index].data();
          final user = FirebaseAuth.instance.currentUser;
          print("before check");
          //print("user.displayName=> ${user.displayName}");
          //print("user.uid=> ${user.uid}");
          //print("data['author_id']=> ${data['author_id']}");
          //print('res=> ${user.uid == data['author_id']}');
          if (user != null && user.uid == data['author_id']) {
            print("checking");
            return Dismissible(
              onDismissed: (_) {
                onDelete(messages[index].id);
              },
              key: ValueKey(data['timestamp']),
              /*child: ChatMessage(
                index: index,
                data: data,
              ),*/
              child: SecondClass(
                index: index,
                data: data,
              ),
            );
          }
          print("didnt enter into check");
          /*return ChatMessageOther(
            index: index,
            data: messages[index].data(),
          );*/
          return ThirdClass(
            index: index,
            data: messages[index].data(),
          );
        });
  }
}
