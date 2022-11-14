import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/player/view_model/player_view_model.dart';
import 'package:rakhsaani/features/surah_list/model/surah.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../view_model/surah_list_view_model.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = context.read<PlayerViewModel>();
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ ٢',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.kArabicTitle,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '1. All the praises and thanks be to Allah, the Lord of the \'Alamin.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.kTranslatedTitle,
                ),
              ),
              const SizedBox(
                height: 50,
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
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.speaker_2,
                      color: onPrimayColor,
                      size: kDefaultIconSize,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: .5,
                    overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.white,
                  min: 0,
                  max: 100,
                  onChanged: (double value) {},
                  value: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '0:00.41',
                      style: AppTextStyles.kPlayerTimerTextStyle,
                    ),
                    Text(
                      '0:01.31',
                      style: AppTextStyles.kPlayerTimerTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                  Image.asset(
                    '${iconUrl}ic_navigate_before.png',
                    width: 15,
                    color: onPrimayColor,
                  ),
                  InkWell(
                    onTap: () {
                      player.isPlaying
                          ? player.pauseAudio()
                          : player.playAudio(
                              Urls.baseUrl +
                                  surah.audio.replaceAll("/media/", ""),
                              surah.surahNumber,
                            );
                    },
                    child: Image.asset(
                      '${iconUrl}ic_play_circle.png',
                      width: 50,
                      color: onPrimayColor,
                    ),
                  ),
                  Image.asset(
                    '${iconUrl}ic_navigate_next.png',
                    width: 15,
                    color: onPrimayColor,
                  ),
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
              context.read<PlayerViewModel>().pauseAudio();
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
