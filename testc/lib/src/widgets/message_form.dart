import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:testc/file1.dart';
import 'package:testc/file.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController mycontroller = TextEditingController();
  String _message;
  void _onPress() {
    print("_onPress()");
    _message = mycontroller.text;  
    /*setState(() {
    _message = mycontroller.text;  
    });*/

    widget.onSubmit(_message);
    print(_message);
    _message = '';
  }

  IconData mic_icon = Icons.mic_off_rounded;
  bool tap = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  bool available = false;
//change padding bottom in Textfield and Icon Widget

  /*void initSpeech() async {
    available = await _speech.initialize(
      onStatus: (v) => print(v),
      onError: (v) => print(v),
    );
    if (available) {
      print("speech initialize");
    } else {
      print("speech else");
    }
  }*/
  void _listen(bool tap) async {
    print("available=> $available");
    var _locale = getLocale();

    if (tap == true) {
      print("speech loc=> $_locale");
      _speech.listen(
          //listenFor: Duration(minutes: 1),
          //pauseFor: Duration(minutes: 1),
          //cancelOnError: true,
          //onDevice: true,
          localeId: _locale,
          onResult: (v) => setState(() {
                mycontroller.text = v.recognizedWords;
                print("spoke=> ${mycontroller.text}");
              }));
    }
    if (tap == false) {
      _speech.stop();
    }
  }

  @override
  void initState() {
    initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 1.0, bottom: 25.0),
              child: IconButton(
                icon: Icon(
                  mic_icon,
                  size: 40.0,
                ),
                onPressed: () async {
                  tap = !tap;
                  print("mic tap=> $tap");
                  setState(() {
                    mic_icon = tap ? Icons.mic_rounded : Icons.mic_off_rounded;
                  });
                  _listen(tap);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: TextField(
                  controller: mycontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'type',
                      hintText: '(sample:)Hope you are having a good day'),
                  maxLines: 5,
                  minLines: 1,
                  onChanged: (v) {
                    setState(() {
                      _message = v;
                      //print("_message:=> $_message");
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    size: 37.0,
                  ),
                  onPressed: () {
                    mycontroller.text == null || mycontroller.text.isEmpty
                        ? null
                        : _onPress();
                    //: print(mycontroller.text);
                    //_message.isEmpty || _message == null ? null : _onPress();
                    mycontroller.clear();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
