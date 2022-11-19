import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../surah_list/view/widgets/seekbar.dart';

class PlayerViewModel with ChangeNotifier {
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isExpnaded = false;
  bool isMute = false;
  int? playingSurahNumber;

  void playAudio(String url, int surahNo) async {
    isPlaying = true;
    isExpnaded = true;
    playingSurahNumber = surahNo;
    notifyListeners();
    await player.setUrl(url);
    await player.play();
  }

  void reumeAudio() {
    isPlaying = true;
    notifyListeners();
    player.play();
  }

  void muteAudio() {
    isMute = !isMute;
    isMute ? player.setVolume(0) : player.setVolume(1);
    notifyListeners();
  }

  void seekToPosition(dynamic position) async {
    await player.seek(position);
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

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
}
