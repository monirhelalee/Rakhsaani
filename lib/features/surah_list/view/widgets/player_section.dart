import 'dart:async';
import 'dart:developer';

import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var player = context.watch<PlayerViewModel>();
    var svm = context.read<SurahListViewModel>();
    var detailVm = context.read<SurahDetailViewModel>();
    int _versePosition = 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kScaffoldBgColor,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder<PositionData>(
                stream: player.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  Duration dur = parseTime(detailVm.surahDetailModel
                          ?.verseAndTime?[_versePosition].timeOut ??
                      "0:00:00.000");
                  if (dur < positionData!.position) {
                    _versePosition++;
                    debugPrint("versePosition ${_versePosition}");
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "$dur ${detailVm.surahDetailModel?.verseAndTime?[_versePosition].text} \n\n${positionData?.position}",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.kPlayerText,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart,
                      color: onPrimayColor,
                      size: kDefaultIconSize,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.muteAudio();
                    },
                    icon: Icon(
                      player.isMute
                          ? CupertinoIcons.speaker_slash
                          : CupertinoIcons.speaker_2,
                      color: onPrimayColor,
                      size: kDefaultIconSize,
                    ),
                  ),
                ],
              ),
              StreamBuilder<PositionData>(
                stream: player.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  _position = snapshot.data?.position;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: player.player.seek,
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
                      onTap: () {
                        _vm.prev();
                        var s = _vm.getSurahByNumber(_vm.selectedSurahNumber!);
                        player.playAudio(
                          "${Urls.baseUrl}${s.surah.audio}",
                          s.surah.surahNumber,
                        );
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
                        player.isPlaying
                            ? player.pauseAudio()
                            : player.reumeAudio();
                        // player.playAudio(
                        //     "${Urls.baseUrl}${s.surah.audio}",
                        //     s.surah.surahNumber,
                        //   );
                      },
                      child: player.isPlaying
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
                      onTap: () {
                        _vm.next();
                        var s = _vm.getSurahByNumber(_vm.selectedSurahNumber!);
                        player.playAudio(
                          "${Urls.baseUrl}${s.surah.audio}",
                          s.surah.surahNumber,
                        );
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
          Positioned(
              child: IconButton(
            onPressed: () {
              context.read<PlayerViewModel>().collapsePlayer();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
          )),
        ],
      ),
    );
  }
}
