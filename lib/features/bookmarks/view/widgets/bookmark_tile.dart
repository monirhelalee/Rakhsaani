import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../../detail/view/detail_screen.dart';
import '../../../detail/view_model/surah_detail_view_model.dart';
import '../../../player/view_model/player_view_model.dart';
import '../../../surah_list/model/surah.dart';
import '../../../surah_list/view_model/surah_list_view_model.dart';

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    super.key,
    required this.index,
    required this.surah,
  });
  final int index;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    var playerVm = context.watch<PlayerViewModel>();
    var detailsVm = context.watch<SurahDetailViewModel>();
    var listVm = context.watch<SurahListViewModel>();
    return InkWell(
      onTap: () async {
        playerVm.pauseAudio();
        playerVm.versePosition = 0;
        context
            .read<SurahListViewModel>()
            .tapSurah(surah.surah?.surahNumber ?? 0);
        await detailsVm
            .fetchSurahDetail(surahNumber: surah.surah?.surahNumber ?? 0)
            .then(
          (value) {
            playerVm.playAudio(
              url: "${Urls.baseUrl}${detailsVm.surahDetailModel?.audio}",
              surahNo: surah.surah?.surahNumber ?? 0,
              listVm: listVm,
              detailsVm: detailsVm,
            );
            // log('selected surah : --------------- ${context.read<SurahListViewModel>().selectedSurahNumber}');
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
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (s) {
          context
              .read<SurahListViewModel>()
              .deleteBookmark(surah.surah!.surahNumber);
          Fluttertoast.showToast(
              msg: "${surah.surah?.name} removed from bookmark",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: toastBGColor,
              textColor: toastTextColor,
              fontSize: 16.0);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            children: [
              Text(
                surah.surah!.surahNumber.toString(),
                style: AppTextStyles.kTileTitleBlack,
              ),
              const SizedBox(width: 25),
              Text(
                surah.surah?.name ?? "",
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
