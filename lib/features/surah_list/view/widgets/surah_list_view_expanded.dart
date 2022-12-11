import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/colors.dart';
import '../../../error_screen/error_screen.dart';
import '../../view_model/surah_list_view_model.dart';
import 'surah_tile_expanded.dart';

class SurahListViewExpanded extends StatelessWidget {
  const SurahListViewExpanded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SurahListViewModel>(
      builder: (context, vm, _) {
        return vm.fetchSurahError != null
            ? const ErrorScreen()
            : ListView.separated(
                itemCount: vm.surahList.length,
                itemBuilder: (context, index) {
                  return SurahTileExpanded(
                    index: index,
                    surah: vm.surahList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      color: onWhiteColor,
                    ),
                  );
                },
              );
      },
    );
  }
}
