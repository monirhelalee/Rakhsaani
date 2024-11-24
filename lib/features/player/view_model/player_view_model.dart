import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../surah_list/view/widgets/seekbar.dart';

class PlayerViewModel with ChangeNotifier {
  final player = AudioPlayer();
  bool isPlaying = false;
  // bool isExpnaded = false;
  bool isMute = false;
  int? playingSurahNumber;
  int? position;
  int versePosition = 0;

  bool _repeatNext = true;
  bool _repeatOne = false;
  bool _random = false;

  toggleRepeatOption() {
    _repeatNext = !_repeatNext;
    _repeatOne = !_repeatOne;
    notifyListeners();
  }

  toggleRandom() {
    _random = !_random;
    notifyListeners();
  }

  void playAudio({required String url, int? surahNo}) async {
    isPlaying = true;
    //isExpnaded = true;
    playingSurahNumber = surahNo;
    notifyListeners();
    // TODO : should we wrap seturl with try catch?
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

  int positionAudio() {
    int _p = player.position.inSeconds;
    notifyListeners();
    return _p;
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
    //isExpnaded = false;
    notifyListeners();
  }

  void pauseAudio() async {
    isPlaying = false;
    // playingSurahNumber = null;
    notifyListeners();
    await player.pause();
  }

  bool get repeatNext => _repeatNext;
  bool get repeatOne => _repeatOne;
  bool get random => _random;
}
