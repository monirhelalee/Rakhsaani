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
    var surahListVm = context.watch<SurahListViewModel>();
    return Column(
      children: [
        surahListVm.isSearchOpen
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextField(
                  controller: surahListVm.searchController,
                  onChanged: (v) {
                    surahListVm.search(value: v);
                  },
                ),
              )
            : const SizedBox(),
        Consumer<SurahListViewModel>(
          builder: (context, vm, _) {
            return vm.fetchSurahError != null
                ? const ErrorScreen()
                : ListView.separated(
                    itemCount: vm.surahSearchList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SurahTile(
                        index: index,
                        surah: vm.surahSearchList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Separator();
                    },
                  );
          },
        ),
      ],
    );
  }
}
