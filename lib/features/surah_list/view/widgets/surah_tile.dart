import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/styles.dart';

import '../../view_model/surah_list_view_model.dart';

class SurahTile extends StatelessWidget {
  const SurahTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<SurahListViewModel>().playSurah();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
            const SizedBox(width: 25),
            const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
