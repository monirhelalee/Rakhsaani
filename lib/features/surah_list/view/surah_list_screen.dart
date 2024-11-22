import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/utils_exports.dart';
import '../view_model/surah_list_view_model.dart';
import 'widgets/menu.dart';
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
    // final vm = context.watch<PlayerViewModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kScaffoldBgColor,
        appBar: AppBar(
          elevation: 1,
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
        body: const SurahListView(),
      ),
    );
  }

  // @override
  // void dispose() {
  //   context.read<PlayerViewModel>().player.dispose();
  //   super.dispose();
  // }
}
