import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../error_screen/error_screen.dart';
import '../../view_model/surah_list_view_model.dart';
import 'separator.dart';
import 'surah_tile.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({
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
                  return SurahTile(
                    index: index,
                    surah: vm.surahList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Separator();
                },
              );
      },
    );
  }
}
