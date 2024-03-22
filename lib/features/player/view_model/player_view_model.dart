import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rakhsaani/core/utils/urls.dart';
import 'package:rakhsaani/features/detail/view_model/surah_detail_view_model.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';

class PlayerViewModel with ChangeNotifier {
  final player = AudioPlayer();
  bool isPlaying = false;
  // bool isExpnaded = false;
  bool isMute = false;
  int? playingSurahNumber;
  int? position;
  int versePosition = 0;

  ///
  late StreamSubscription<Duration> stream;
  Duration _currentTime = Duration.zero;
  Duration _totalTime = const Duration(milliseconds: 1);

  bool _repeatNext = true;
  bool _repeatOne = false;
  bool _random = false;

  set currentTime(v) {
    _currentTime = v;
    notifyListeners();
  }

  toggleRepeatOption() {
    _repeatNext = !_repeatNext;
    _repeatOne = !_repeatOne;
    notifyListeners();
  }

  toggleRandom() {
    _random = !_random;
    notifyListeners();
  }

  void playAudio({
    required String url,
    required int surahNo,
    required SurahListViewModel listVm,
    required SurahDetailViewModel detailsVm,
  }) async {
    isPlaying = true;
    playingSurahNumber = surahNo;
    _totalTime =
        parseDuration(listVm.surahList[surahNo - 1].duration ?? '0:0:0');
    _currentTime = Duration.zero;
    log('$_totalTime');
    notifyListeners();
    await player.setSourceUrl(url);
    log(url);
    await player.play(UrlSource(url));

    player.onPositionChanged.listen((Duration position) {
      _currentTime = position;
      notifyListeners();
    });
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        player.stop();
        if (random) {
          Future.delayed(Duration.zero, () async {
            listVm.getRandomSurahNumber();
            log('Playing random surah');
            await detailsVm
                .fetchSurahDetail(surahNumber: listVm.selectedSurahNumber!)
                .then((value) {
              versePosition = 0;
              playAudio(
                url: "${Urls.baseUrl}${detailsVm.surahDetailModel?.audio}",
                detailsVm: detailsVm,
                surahNo: listVm.selectedSurahNumber!,
                listVm: listVm,
              );
            });
          });
        } else {
          if (repeatNext) {
            log('Playing next surah');
            Future.delayed(Duration.zero, () async {
              player.stop();
              listVm.next();
              await detailsVm
                  .fetchSurahDetail(surahNumber: listVm.selectedSurahNumber!)
                  .then((value) {
                versePosition = 0;
                playAudio(
                  url: "${Urls.baseUrl}${detailsVm.surahDetailModel?.audio}",
                  listVm: listVm,
                  surahNo: listVm.selectedSurahNumber!,
                  detailsVm: detailsVm,
                );
              });
            });
          } else {
            Future.delayed(Duration.zero, () async {
              versePosition = 0;
              player.seek(Duration.zero);
              player.resume();
            });
          }
        }
      }
    });
    // player.onPlayerStateChanged.listen((PlayerState s) async {
    //   if (s == PlayerState.completed) {
    //     if (!_isCalled) {
    //       _selectedIndex = _selectedIndex! + 1;
    //       _isCalled = true;
    //       if (selectedIndex == 114) {
    //         _selectedIndex = 0;
    //         await loadAudio();
    //       } else {
    //         await loadAudio();
    //       }
    //     }
    //   }
    //   if (s == PlayerState.playing) {
    //     NotificationService.updateNotification(NotificationPlayState.playing);
    //   }
    // });
  }

  void reumeAudio() {
    isPlaying = true;
    notifyListeners();
    player.resume();
  }

  void muteAudio() {
    isMute = !isMute;
    isMute ? player.setVolume(0) : player.setVolume(1);
    notifyListeners();
  }

  // int positionAudio() {
  //   int _p = player.position.inSeconds;
  //   notifyListeners();
  //   return _p;
  // }

  void seekToPosition(dynamic position) async {
    await player.seek(position);
  }

  // Stream<PositionData> get positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //       player.positionStream,
  //       player.bufferedPositionStream,
  //       player.durationStream,
  //       (position, bufferedPosition, duration) =>
  //           PositionData(position, bufferedPosition, duration ?? Duration.zero),
  //     );

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

  ///
  Duration parseDuration(String durationString) {
    List<String> parts =
        durationString.split(':'); // Splitting the string by colon

    // Parsing hours, minutes, and seconds from the string parts
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    // Creating a Duration object
    Duration duration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    return duration;
  }

  bool get repeatNext => _repeatNext;
  bool get repeatOne => _repeatOne;
  bool get random => _random;
  Duration get currentTime => _currentTime;
  Duration get totalTime => _totalTime;
}
