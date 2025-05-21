import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
class DoctorTTS {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentLanguage = "en-US";
  //   final Map<String, String> supportedLanguages = {
  //   "English": "en-US",
  //   "Vietnamese": "vi-VN",
  //   "French": "fr-FR",
  //   "Spanish": "es-ES",
  //   "German": "de-DE",
  //   "Chinese": "zh-CN",
  //   "Japanese": "ja-JP",
  //   "Korean": "ko-KR",
  // };
  Future<String> speak(String text) async {
    if (text.isEmpty) return "Text is empty";
    if (text.length > 200) return "Text is too long. Please limit to 200 characters.";
    
    try {
      if (isPlaying) {
        await audioPlayer.stop();
      }
      
      final encodedText = Uri.encodeComponent(text);
      final ttsUrl = 'https://translate.google.com/translate_tts?ie=UTF-8&q=$encodedText&tl=${currentLanguage ?? "en-US"}&client=tw-ob';
      
      audioPlayer.onPlayerStateChanged.listen( (state) =>
        isPlaying = state == PlayerState.playing
      );
      
      await audioPlayer.play(UrlSource(ttsUrl));
      return "Playing...";
    } catch (e) 
    {
      return "Error: $e"; 
    }
  }
  Future<void> stop() async {
    if (isPlaying) {
      await audioPlayer.stop();
      isPlaying = false;
    }
  }
    void dispose() {
    audioPlayer.dispose();
  }
}