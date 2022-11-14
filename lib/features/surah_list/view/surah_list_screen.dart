import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/player/view_model/player_view_model.dart';
import 'package:rakhsaani/features/surah_list/view/widgets/surah_list_view_expanded.dart';
import '../../../core/utils/utils_exports.dart';
import '../view_model/surah_list_view_model.dart';
import 'widgets/menu.dart';
import 'widgets/player_section.dart';
import 'widgets/search_surah.dart';
import 'widgets/surah_list_view.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurahListViewModel>().fetchSurahList();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PlayerViewModel>();
    return Scaffold(
      backgroundColor: vm.isExpnaded ? Colors.white : kScaffoldBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Surah List',
          style: TextStyle(color: onPrimayColor),
        ),
        automaticallyImplyLeading: false,
        leading: const SearchSurah(),
        actions: const [
          Menu(),
        ],
      ),
      body: vm.isExpnaded
          ? Column(
              children: const [
                Expanded(
                  child: PlayerSection(),
                ),
                Expanded(child: SurahListViewExpanded()),
              ],
            )
          : const SurahListView(),
    );
  }
}
