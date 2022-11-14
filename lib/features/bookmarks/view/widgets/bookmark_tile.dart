import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';

import '../../../../core/utils/asset_path.dart';

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        child: Row(
          children: [
            Text(
              '${index + 1}',
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 25),
            Text(
              'Surah ${index + 1}',
              style: AppTextStyles.kTileTitleBlack,
            ),
            const Spacer(),
            const Text(
              '0:01:31',
              style: AppTextStyles.kTileTitleBlack,
            ),
            const SizedBox(width: 40),
            Image.asset(
              '${iconUrl}ic_bookmarks.png',
              width: 20,
              color: onWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
