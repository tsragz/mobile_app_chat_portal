import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'package:testc/file.dart';
class ThirdClass extends StatefulWidget {
  final int index;
  final Map<String, dynamic> data;
  ThirdClass({Key key, this.index, this.data}) : super(key: key);

  @override
  _ThirdClassState createState() =>
      _ThirdClassState(index: this.index, data: this.data);
}

class _ThirdClassState extends State<ThirdClass> {
  int index;
  Map<String, dynamic> data;
  _ThirdClassState({this.index, this.data});
  var _locale = getLocale();
  var _languages = getLanguages();
  FlutterTts tts = FlutterTts();
  Future _speak(String text) async {
      await tts.setSpeechRate(1.0);
      await tts.setVolume(1.0);
      await tts.setPitch(0.9);
      await tts.speak(text);
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 17,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            //child: Text('jccnnccscisjcisjisjvomvfkmvofjofmdfmoffodm fofvofvofv'),
            decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['author'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  child: Text(
                    data['value'],
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.lime[900],
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: ()async {
                    print("pressed");
                    _locale = getLocale().toString();
                  tts.setLanguage("$_locale");
                  var msg = await '${data['value']}'.translate(to:_locale.split('_')[0]);
                  setState(() {
                    data['value'] = msg.text;
                  });

                  print(msg.text);
                  _speak(msg.text);
                  },
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 87)),
        ],
      ),
    );
  }
}
