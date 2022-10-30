import 'package:flutter/material.dart';
import 'widgets/menu.dart';
import 'widgets/search_surah.dart';
import 'widgets/separator.dart';
import 'widgets/surah_tile.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Surah List'),
        automaticallyImplyLeading: false,
        leading: const SearchSurah(),
        actions: const [
          Menu(),
        ],
      ),
      body: ListView.separated(
        itemCount: 114,
        itemBuilder: (context, index) {
          return SurahTile(
            index: index,
          );
        },
        separatorBuilder: (context, index) {
          return const Separator();
        },
      ),
    );
  }
}




