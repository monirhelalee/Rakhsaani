import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/detail/view/detail_screen.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../../detail/view_model/surah_detail_view_model.dart';
import '../../../player/view_model/player_view_model.dart';
import '../../model/surah.dart';
import '../../view_model/surah_list_view_model.dart';

class SurahTile extends StatelessWidget {
  const SurahTile({
    Key? key,
    required this.index,
    required this.surah,
  }) : super(key: key);

  final int index;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    var playerVm = context.watch<PlayerViewModel>();
    var detailsVm = context.watch<SurahDetailViewModel>();
    return InkWell(
      onTap: () async {
        // context
        //     .read<SurahListViewModel>()
        //     .getSurahByNumber(surah.surah?.surahNumber ?? 0);
        // context
        //     .read<SurahListViewModel>()
        //     .tapSurah(surah.surah?.surahNumber ?? 1);
        playerVm.versePosition = 0;
        await detailsVm
            .fetchSurahDetail(surahNumber: surah.surah?.surahNumber ?? 0)
            .then(
          (value) {
            context
                .read<SurahListViewModel>()
                .tapSurah(surah.surah?.surahNumber ?? 0);
            playerVm.playAudio(
                url: "${Urls.baseUrl}${detailsVm.surahDetailModel?.audio}");
            log('selected surah : --------------- ${context.read<SurahListViewModel>().selectedSurahNumber}');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetailScreen(
                  index: index,
                  name: surah.surah?.name ?? '',
                  surahNumber: surah.surah?.surahNumber ?? 0,
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: [
            Text(
              "${surah.surah?.surahNumber ?? 0}",
              style: AppTextStyles.kTileTitle,
            ),
            const SizedBox(width: 25),
            Text(
              surah.surah?.name ?? "",
              style: AppTextStyles.kTileTitle,
            ),
            const Spacer(),
            Text(
              surah.duration ?? "",
              style: AppTextStyles.kTileTitle,
            ),
            const SizedBox(width: 40),
            surah.surah?.surahNumber == playerVm.playingSurahNumber
                ? playerVm.isPlaying
                    ? Lottie.asset(
                        '${imageUrl}eq.json',
                        width: 30,
                      )
                    : Image.asset(
                        '${iconUrl}ic_play_circle.png',
                        width: 30,
                        color: onPrimayColor,
                      )
                : Image.asset(
                    '${iconUrl}ic_play_circle.png',
                    width: 30,
                    color: onPrimayColor,
                  ),
          ],
        ),
      ),
    );
  }
}
