import 'package:flutter/material.dart';
//import 'package:testc/drop_down.dart';
//import 'package:testc/count.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'package:testc/file.dart';

class ChatMessage extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const ChatMessage({Key key, this.index, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _locale = getLocale();
    var _languages = getLanguages();
    FlutterTts tts = FlutterTts();
    Future _speak(String text) async {
      await tts.setSpeechRate(1.0);
      await tts.setVolume(1.0);
      await tts.setPitch(0.9);
      await tts.speak(text);
    }

    return Container(
      margin: EdgeInsets.only(right: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['author'],
                  style: TextStyle(
                    color: Colors.amberAccent[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                // SizedBox(height: 5),
                TextButton(
                  child: Text(
                    data['value'],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    print("pressed");
                    _locale = getLocale().toString();
                    tts.setLanguage("$_locale");
                    var msg = await '${data['value']}'
                        .translate(to: _locale.split('_')[0]);
                    print(msg.text);
                    //_speak(msg.text);
                  },
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
