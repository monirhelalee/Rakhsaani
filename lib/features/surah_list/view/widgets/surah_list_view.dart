import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/colors.dart';
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
            ? Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: TextField(
                  autofocus: true,
                  controller: surahListVm.searchController,
                  onChanged: (v) {
                    surahListVm.search(value: v);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    fillColor: onPrimayColor,
                    contentPadding: const EdgeInsets.all(8),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Consumer<SurahListViewModel>(
          builder: (context, vm, _) {
            return vm.fetchSurahError != null
                ? const ErrorScreen()
                : Expanded(
                    child: ListView.separated(
                      itemCount: vm.surahSearchList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SurahTile(
                          index: index,
                          surah: vm.surahSearchList[index],
                          vm: vm,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Separator();
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}
