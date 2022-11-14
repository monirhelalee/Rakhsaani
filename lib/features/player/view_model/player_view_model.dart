import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerViewModel with ChangeNotifier {
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isExpnaded = false;
  int? playingSurahNumber;

  void playAudio(String url, int surahNo) async {
    isPlaying = true;
    isExpnaded = true;
    playingSurahNumber = surahNo;
    notifyListeners();
    await player.setUrl(url);
    await player.play();
  }

  void collapsePlayer() {
    isExpnaded = false;
    notifyListeners();
  }

  void pauseAudio() async {
    isPlaying = false;
    // playingSurahNumber = null;
    notifyListeners();
    await player.pause();
  }

  void playNext()async{
    await player.seekToNext();
  }

   void playPrev()async{
    await player.seekToPrevious();
  }
}
