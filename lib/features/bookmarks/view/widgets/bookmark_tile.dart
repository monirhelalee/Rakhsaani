import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/styles.dart';
import 'package:rakhsaani/features/surah_list/model/surah.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';
import '../../../../core/utils/asset_path.dart';

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    Key? key,
    required this.index,
    required this.surah,
  }) : super(key: key);
  final int index;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (s) {
          context.read<SurahListViewModel>().deleteBookmark(surah.id);
          Fluttertoast.showToast(
              msg: "${surah.surah.name} removed from bookmark",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Row(
            children: [
              Text(
                surah.id.toString(),
                style: AppTextStyles.kTileTitleBlack,
              ),
              const SizedBox(width: 25),
              Text(
                surah.surah.name,
                style: AppTextStyles.kTileTitleBlack,
              ),
              const Spacer(),
              Text(
                surah.duration.toString(),
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
      ),
    );
  }
}
