import 'dart:async';
import 'dart:developer';

import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../../detail/view_model/surah_detail_view_model.dart';
import '../../../player/view_model/player_view_model.dart';
import '../../view_model/surah_list_view_model.dart';
import 'seekbar.dart';

class PlayerSection extends StatefulWidget {
  const PlayerSection({
    Key? key,
    required this.surahNumber,
  }) : super(key: key);

  final int surahNumber;

  @override
  State<PlayerSection> createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  Duration? _position;
  var x = 0;
  // @override
  // void initState() {
  //   Timer.run(() {
  //     _position = context.read<PlayerViewModel>().player.position;
  //     setState(() {});
  //   });
  //
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) {
  //       context.read<SurahDetailViewModel>().fetchSurahDetail();
  //       Future.delayed(const Duration(seconds: 1), () {
  //         fetchAndPlay();
  //       });
  //     },
  //   );
  // }

  void fetchAndPlay() {
    context.read<PlayerViewModel>().player.setUrl(
        "${Urls.baseUrl}${context.read<SurahDetailViewModel>().surahDetailModel!.audio}");
    // context.read<PlayerViewModel>().playAudio(
    //       Urls.baseUrl +
    //           context.read<SurahDetailViewModel>().surahDetailModel!.audio,
    //       context.read<SurahDetailViewModel>().surahDetailModel!.surahNumber,
    //     );
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
            StreamBuilder<PositionData>(
              stream: playerVm.positionDataStream,
              builder: (context, snapshot) {
                // debugPrint("versePosition ${playerVm.versePosition}");
                // debugPrint("player.position ${playerVm.player.position}");
                // debugPrint("player.playing ${playerVm.player.playing}");
                // debugPrint("player.hasNext ${playerVm.player.hasNext}");
                debugPrint(
                    "playerVm.player.playerState ${playerVm.player.playerState.processingState}");
                if (playerVm.player.playerState.processingState ==
                    ProcessingState.completed) {
                  // playerVm.player.stop();
                  Future.delayed(Duration.zero, () async {
                    if (!playerVm.random) {
                      if (playerVm.repeatNext) {
                        surahListVm.next();
                        log('Playing next surah');
                        await detailVm
                            .fetchSurahDetail(
                                surahNumber: surahListVm.selectedSurahNumber!)
                            .then((value) {
                          playerVm.versePosition = 0;
                          playerVm.playAudio(
                            url:
                                "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
                          );
                        });
                      } else {
                        // Play the same surah
                        log('Playing same surah');
                        await detailVm
                            .fetchSurahDetail(
                                surahNumber: surahListVm.selectedSurahNumber!)
                            .then((value) {
                          playerVm.versePosition = 0;
                          playerVm.playAudio(
                            url:
                                "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
                          );
                        });
                      }
                    } else {
                      surahListVm.getRandomSurahNumber();
                      log('Playing random surah');
                      await detailVm
                          .fetchSurahDetail(
                              surahNumber: surahListVm.selectedSurahNumber!)
                          .then((value) {
                        playerVm.versePosition = 0;
                        playerVm.playAudio(
                          url:
                              "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
                        );
                      });
                    }
                  });

                  // debugPrint("Stop Playing");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (detailVm.surahDetailModel == null) {
                    return Text('............');
                  } else {
                    final positionData = snapshot.data;
                    Duration dur = playerVm.versePosition >=
                            detailVm.surahDetailModel!.verseAndTime.length
                        ? parseTime(detailVm
                            .surahDetailModel!.verseAndTime.last.timeOut)
                        : parseTime(detailVm
                                .surahDetailModel
                                ?.verseAndTime[playerVm.versePosition]
                                .timeOut ??
                            "0:00:00.000");
                    if (dur < positionData!.position) {
                      if (playerVm.versePosition <
                          detailVm.surahDetailModel!.verseAndTime.length) {
                        playerVm.versePosition++;
                        debugPrint("versePosition ${playerVm.versePosition}");
                      }
                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      x = detailVm.surahDetailModel!.verseAndTime.indexWhere(
                          (e) =>
                              DateFormat('HH:mm:ss.S')
                                      .parse(e.timeIn, true)
                                      .millisecondsSinceEpoch <=
                                  positionData.position.inMilliseconds &&
                              DateFormat('HH:mm:ss.S')
                                      .parse(e.timeOut, true)
                                      .millisecondsSinceEpoch >=
                                  positionData.position.inMilliseconds);
                    });

                    log(x.toString());
                    // log('---------  ${positionData.position.inMilliseconds.toString()}  -----------');
                    // log('---------  ${DateFormat('HH:mm:ss.S').parse(detailVm.surahDetailModel!.verseAndTime[1].timeIn, true).microsecondsSinceEpoch}  -----------');
                    // log('${DateFormat('HH:mm:ss.S').parse(detailVm.surahDetailModel!.verseAndTime.last.timeIn, true).microsecondsSinceEpoch}');
                    // // log('${Date(detailVm.surahDetailModel!.verseAndTime.first.timeIn.substring(0, 7))}');

                    // log("${detailVm.surahDetailModel?.verseAndTime[_versePosition].text}");
                    // playerVm.player.playerStateStream.listen((playerState) {
                    //   if (playerState.processingState ==
                    //       ProcessingState.completed) {
                    //     log('message');
                    //     // context.read<SurahListViewModel>().next();
                    //     var s = svm.getSurahByNumber(svm.selectedSurahNumber!);
                    //     // player.playAudio(
                    //     //   "${Urls.baseUrl}${s.surah?.audio}",
                    //     //   s.surah?.surahNumber??0,
                    //     // );
                    //     // context
                    //     //     .read<SurahDetailViewModel>()
                    //     //     .fetchSurahDetail();
                    //   }
                    // });
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
                  }
                }
              },
            ),
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
            StreamBuilder<PositionData>(
              stream: playerVm.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                _position = snapshot.data?.position;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: playerVm.player.seek,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: playerVm.random
                      ? () {
                          Fluttertoast.showToast(
                            msg: "Can not repeat while shuffle is on",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: toastBGColor,
                            textColor: toastTextColor,
                            fontSize: 16.0,
                          );
                        }
                      : () {
                          playerVm.toggleRepeatOption();
                          Fluttertoast.showToast(
                            msg: playerVm.repeatNext
                                ? "Repeat Off"
                                : "Repeat On",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: toastBGColor,
                            textColor: toastTextColor,
                            fontSize: 16.0,
                          );
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
                  return InkWell(
                    onTap: () async {
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
                    Fluttertoast.showToast(
                      msg: playerVm.random ? "Shuffle On" : "Shuffle Off",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: toastBGColor,
                      textColor: toastTextColor,
                      fontSize: 16.0,
                    );
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
