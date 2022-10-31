import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/utils_exports.dart';
import '../view_model/surah_list_view_model.dart';
import 'widgets/menu.dart';
import 'widgets/player_section.dart';
import 'widgets/search_surah.dart';
import 'widgets/surah_list_view.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SurahListViewModel>();
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Surah List'),
        automaticallyImplyLeading: false,
        leading: const SearchSurah(),
        actions: const [
          Menu(),
        ],
      ),
      body: vm.isPlayerExpanded
          ? Column(
              children: const [
                Expanded(
                  child: PlayerSection(),
                ),
                Expanded(child: SurahListView()),
              ],
            )
          : const SurahListView(),
    );
  }
}