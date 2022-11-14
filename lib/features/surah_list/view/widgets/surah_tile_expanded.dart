import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';
import 'package:rakhsaani/features/player/view_model/player_view_model.dart';

import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/urls.dart';
import '../../model/surah.dart';
import '../../view_model/surah_list_view_model.dart';

class SurahTileExpanded extends StatelessWidget {
  const SurahTileExpanded({
    Key? key,
    required this.index,
    required this.surah,
  }) : super(key: key);

  final int index;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    var player = context.read<PlayerViewModel>();
    return GestureDetector(
      onTap: () {
        player.isPlaying
            ? player.pauseAudio()
            : player.playAudio(
                Urls.baseUrl + surah.audio.replaceAll("/media/", ""),
                surah.surahNumber,
              );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: [
            Text(
              surah.surahNumber.toString(),
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 25),
            Text(
              surah.name,
              style: AppTextStyles.kTileTitleBlack,
            ),
            const Spacer(),
            const Text(
              '0:01:31',
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 40),
            Consumer<PlayerViewModel>(
              builder: (context, player, _) {
                return InkWell(
                  onTap: () {
                    player.playAudio(
                      Urls.baseUrl + surah.audio.replaceAll("/media/", ""),
                      surah.surahNumber,
                    );
                  },
                  child: surah.surahNumber == player.playingSurahNumber
                      ? player.isPlaying
                          ? Lottie.asset(
                              '${imageUrl}eq.json',
                              width: 30,
                            )
                          : Image.asset(
                              '${iconUrl}ic_play_circle.png',
                              width: 30,
                              color: onWhiteColor,
                            )
                      : Image.asset(
                          '${iconUrl}ic_play_circle.png',
                          width: 30,
                          color: onWhiteColor,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
