import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';
import 'package:rakhsaani/features/player/view_model/player_view_model.dart';

import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/urls.dart';
import '../../../detail/view_model/surah_detail_view_model.dart';
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
    var player = context.watch<PlayerViewModel>();
    var listVm = context.read<SurahListViewModel>();
    var detailVm = context.read<SurahDetailViewModel>();
    return InkWell(
      onTap: () async {
        listVm.tapSurah(surah.surah?.surahNumber ?? 0);
        // context.read<SurahDetailViewModel>().fetchSurahDetail();
        // player.playAudio(
        //   Urls.baseUrl + surah.surah.audio,
        //   surah.surah.surahNumber,
        // );
        await detailVm
            .fetchSurahDetail(surahNumber: listVm.selectedSurahNumber!)
            .then((value) {
          player.versePosition = 0;
          player.playAudio(
            url: "${Urls.baseUrl}${detailVm.surahDetailModel?.audio}",
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: [
            Text(
              "${surah.surah?.surahNumber ?? 0}",
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 25),
            Text(
              "${surah.surah?.name ?? ""}",
              style: AppTextStyles.kTileTitleBlack,
            ),
            const Spacer(),
            Text(
              "${surah.duration ?? "0"}",
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 40),
            Consumer<PlayerViewModel>(
              builder: (context, player, _) {
                return surah.surah?.surahNumber == listVm.selectedSurahNumber
                    ? player.player.playing || player.isPlaying
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
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
