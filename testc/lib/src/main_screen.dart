import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testc/src/auth/android_auth_provider.dart';
import 'package:testc/src/widgets/message_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testc/src/widgets/message_wall.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:testc/drop_down.dart';
import 'package:testc/file1.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Message'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final store = FirebaseFirestore.instance.collection('chat_messages');
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _signedIn = false;
  //bool available = false;
  //stt.SpeechToText _speech = stt.SpeechToText();
  void _signIn() async {
    try {
      final creds = await AuthProvider().signInWithGoogle();
      print(creds);
      setState(() {
        _signedIn = true;
      });
    } catch (e) {
      print("Login failed $e");
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _signedIn = false;
    });
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await widget.store.add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'value': value,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
      });
    }
  }

  void _deleteMessage(String docId) async {
    await widget.store.doc(docId).delete();
  }
  @override
  void initState() {
    // TODO: implement initState
    initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (_signedIn)
            InkWell(
              onTap: _signOut,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(Icons.logout),
              ),
            )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirstClass(),
            Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: widget.store.orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.isEmpty) {
                    return Container(
                      child: Text('no messages to display'),
                    );
                  }
                  return MessageWall(
                    messages: snapshot.data.docs,
                    onDelete: _deleteMessage,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            if (!_signedIn)
              Container(
                padding: EdgeInsets.all(30),
                child: SignInButton(Buttons.Google, onPressed: _signIn),
              )
            else
              MessageForm(
                onSubmit: (v) {
                  print("#=> $v");
                  _addMessage(v);
                },
              )
          ],
        ),
      ),
    );
  }
}
