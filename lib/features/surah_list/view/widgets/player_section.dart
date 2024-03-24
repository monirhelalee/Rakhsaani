import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/utils_exports.dart';

import '../../../../core/utils/constant.dart';
import '../../../../core/utils/urls.dart';
import '../../../detail/view_model/surah_detail_view_model.dart';
import '../../../player/view_model/player_view_model.dart';
import '../../view_model/surah_list_view_model.dart';

class PlayerSection extends StatefulWidget {
  const PlayerSection({
    super.key,
    required this.surahNumber,
  });

  final int surahNumber;

  @override
  State<PlayerSection> createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  var x = 0;

  void fetchAndPlay() {
    context.read<PlayerViewModel>().player.setSourceUrl(
        "${Urls.baseUrl}${context.read<SurahDetailViewModel>().surahDetailModel!.audio}");
  }

  @override
  Widget build(BuildContext context) {
    var playerVm = context.watch<PlayerViewModel>();
    var surahListVm = context.read<SurahListViewModel>();
    var detailVm = context.read<SurahDetailViewModel>();

    log('build');
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kScaffoldBgColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<SurahDetailViewModel>(builder: (context, detailVm, _) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                x = detailVm.surahDetailModel!.verseAndTime.indexWhere((e) =>
                    DateFormat('HH:mm:ss.S')
                            .parse(e.timeIn, true)
                            .millisecondsSinceEpoch <=
                        playerVm.currentTime.inMilliseconds &&
                    DateFormat('HH:mm:ss.S')
                            .parse(e.timeOut, true)
                            .millisecondsSinceEpoch >=
                        playerVm.currentTime.inMilliseconds);
              });
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        x.isNegative
                            ? '...'
                            : "${detailVm.surahDetailModel?.verseAndTime[x].text}",
                        // : "${detailVm.surahDetailModel?.verseAndTime[playerVm.versePosition].text}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.kPlayerText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    surahListVm.addBookmarks(
                      detailVm.surahDetailModel!.surahNumber,
                    );
                    Fluttertoast.showToast(
                        msg: "Bookmark Added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: toastBGColor,
                        textColor: toastTextColor,
                        fontSize: 16.0);
                  },
                  icon: const Icon(
                    CupertinoIcons.heart,
                    color: onPrimayColor,
                    size: kDefaultIconSize,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    playerVm.muteAudio();
                  },
                  icon: Icon(
                    playerVm.isMute
                        ? CupertinoIcons.speaker_slash
                        : CupertinoIcons.speaker_2,
                    color: onPrimayColor,
                    size: kDefaultIconSize,
                  ),
                ),
              ],
            ),
            Slider(
              onChangeEnd: (value) {
                final duration = playerVm.totalTime;
                final position = value * duration.inMilliseconds;
                playerVm.player.seek(Duration(milliseconds: position.round()));
              },
              value: (playerVm.currentTime.inMilliseconds > 0 &&
                      playerVm.currentTime.inMilliseconds <
                          playerVm.totalTime.inMilliseconds)
                  ? playerVm.currentTime.inMilliseconds /
                      playerVm.totalTime.inMilliseconds
                  : 0.0,
              onChanged: (double value) {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                            .firstMatch("${playerVm.currentTime}")
                            ?.group(1) ??
                        '${playerVm.currentTime}',
                    style: AppTextStyles.kPlayerTimerTextStyle,
                  ),
                  Text(
                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                            .firstMatch("${playerVm.totalTime}")
                            ?.group(1) ??
                        '${playerVm.totalTime}',
                    style: AppTextStyles.kPlayerTimerTextStyle,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    playerVm.toggleRandom();
                    if (playerVm.random) {
                      Fluttertoast.showToast(
                        msg: "Shuffle On",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: toastBGColor,
                        textColor: toastTextColor,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Repeat On",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: toastBGColor,
                        textColor: toastTextColor,
                        fontSize: 16.0,
                      );
                    }
                  },
                  icon: Icon(
                    playerVm.repeatNext
                        ? CupertinoIcons.repeat
                        : CupertinoIcons.repeat_1,
                    color: playerVm.random ? Colors.grey : onPrimayColor,
                    size: 18,
                  ),
                ),
                Consumer<SurahListViewModel>(builder: (context, _vm, _) {
                  int index = (_vm.selectedSurahNumber ?? 0) - 1;
                  return InkWell(
                    onTap: () async {
                      playerVm.pauseAudio();
                      _vm.prev();
                      await context
                          .read<SurahDetailViewModel>()
                          .fetchSurahDetail(
                              surahNumber: _vm.selectedSurahNumber!)
                          .then((value) {
                        playerVm.versePosition = 0;
                        playerVm.playAudio(
                          url:
                              "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
                          surahNo: _vm.selectedSurahNumber!,
                          listVm: _vm,
                          detailsVm: detailVm,
                        );
                      });
                    },
                    child: Image.asset(
                      '${iconUrl}ic_navigate_before.png',
                      width: 15,
                      color: onPrimayColor,
                    ),
                  );
                }),
                Consumer<SurahListViewModel>(builder: (context, _vm, _) {
                  return InkWell(
                    onTap: () {
                      //var s = _vm.getSurahByNumber(_vm.selectedSurahNumber);
                      playerVm.isPlaying
                          ? playerVm.pauseAudio()
                          : playerVm.reumeAudio();
                      // player.playAudio(
                      //     "${Urls.baseUrl}${s.surah.audio}",
                      //     s.surah.surahNumber,
                      //   );
                    },
                    child: playerVm.isPlaying
                        ? Image.asset(
                            '${iconUrl}pause.png',
                            height: 43,
                            color: onPrimayColor,
                          )
                        : Image.asset(
                            '${iconUrl}ic_play_circle.png',
                            height: 50,
                            color: onPrimayColor,
                          ),
                  );
                }),
                Consumer<SurahListViewModel>(builder: (context, _vm, _) {
                  int index = (_vm.selectedSurahNumber ?? 0) - 1;
                  return InkWell(
                    onTap: () async {
                      _vm.next();
                      log(_vm.selectedSurahNumber.toString());
                      // var s = _vm.getSurahByNumber( detailVm.surahDetailModel!.surahNumber);
                      await context
                          .read<SurahDetailViewModel>()
                          .fetchSurahDetail(
                              surahNumber: _vm.selectedSurahNumber!)
                          .then((value) {
                        playerVm.versePosition = 0;
                        playerVm.playAudio(
                          url:
                              "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
                          surahNo: _vm.selectedSurahNumber!,
                          listVm: _vm,
                          detailsVm: detailVm,
                        );
                      });
                    },
                    child: Image.asset(
                      '${iconUrl}ic_navigate_next.png',
                      width: 15,
                      color: onPrimayColor,
                    ),
                  );
                }),
                IconButton(
                  onPressed: () {
                    playerVm.toggleRandom();
                    if (playerVm.random) {
                      Fluttertoast.showToast(
                        msg: "Shuffle On",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: toastBGColor,
                        textColor: toastTextColor,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Repeat On",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: toastBGColor,
                        textColor: toastTextColor,
                        fontSize: 16.0,
                      );
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.shuffle,
                    color: playerVm.random ? onPrimayColor : Colors.grey,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    });
  }
}
