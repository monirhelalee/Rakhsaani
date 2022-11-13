import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';
import 'package:rakhsaani/features/surah_list/model/surah.dart';

import '../../../../core/utils/urls.dart';
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
    return InkWell(
      onTap: () {
        context.read<SurahListViewModel>().playSurah();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: [
            Text(
              surah.surahNumber.toString(),
              style: AppTextStyles.kTileTitle,
            ),
            const SizedBox(width: 25),
            Text(
              surah.name,
              style: AppTextStyles.kTileTitle,
            ),
            const Spacer(),
            // TODO: implement time
            const Text(
              '0:01:31',
              style: AppTextStyles.kTileTitle,
            ),
            const SizedBox(width: 40),
            Image.asset(
              '${Urls.iconUrl}ic_play_circle.png',
              width: 30,
              color: onPrimayColor,
            ),
          ],
        ),
      ),
    );
  }
}
