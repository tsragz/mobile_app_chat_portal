import 'package:speech_to_text/speech_to_text.dart' as stt;
stt.SpeechToText _speech = stt.SpeechToText();
bool available = false;
void initSpeech() async {
    available = await _speech.initialize(
    onStatus: (v) => print(v),
    onError: (v) => print(v),
  );
  if (available) {
    print("speech initialize");
  } else {
    print("speech else");
  }
}

