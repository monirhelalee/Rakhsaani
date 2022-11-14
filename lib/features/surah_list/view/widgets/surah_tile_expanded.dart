import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';

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
    return GestureDetector(
      onTap: () {
        context.read<SurahListViewModel>().playSurah();
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
            Text(
              '0:01:31',
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 40),
            Image.asset(
              '${iconUrl}ic_play_circle.png',
              width: 30,
              color: onWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
