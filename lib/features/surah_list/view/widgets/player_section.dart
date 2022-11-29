import 'dart:async';
import 'dart:developer';

import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/detail/view_model/surah_detail_view_model.dart';
import 'package:rakhsaani/features/player/view_model/player_view_model.dart';
import 'package:rakhsaani/features/surah_list/view/widgets/seekbar.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../view_model/surah_list_view_model.dart';

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
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  playerVm.player.stop();
                  Future.delayed(Duration.zero, () async {
                    surahListVm.next();
                    log(surahListVm.selectedSurahNumber.toString());
                    // var s = _vm.getSurahByNumber( detailVm.surahDetailModel!.surahNumber);
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
                  });

                  debugPrint("Stop Playing");
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
                      child: Text(
                        (playerVm.versePosition >=
                                detailVm.surahDetailModel!.verseAndTime.length)
                            ? "${detailVm.surahDetailModel?.verseAndTime.last.text}"
                            : "${detailVm.surahDetailModel?.verseAndTime[playerVm.versePosition].text}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.kPlayerText.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.repeat,
                    color: onPrimayColor,
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
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.shuffle,
                    color: onPrimayColor,
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
