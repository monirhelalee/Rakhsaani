import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';

import '../../../../core/utils/urls.dart';
import '../../view_model/surah_list_view_model.dart';

class SurahTile extends StatelessWidget {
  const SurahTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

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
              '${index + 1}',
              style: AppTextStyles.kTileTitle,
            ),
            const SizedBox(width: 25),
            Text(
              'Surah ${index + 1}',
              style: AppTextStyles.kTileTitle,
            ),
            const Spacer(),
            Text(
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
