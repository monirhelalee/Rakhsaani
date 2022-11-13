import 'package:flutter/material.dart';
import 'package:rakhsaani/features/surah_list/model/surah.dart';
import '../../core/utils/colors.dart';
import '../surah_list/view/widgets/surah_tile_expanded.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  final surah = List.generate(10, (index) => 'Surah + ${index + 1}');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final s = surah.where(
      (e) {
        return e.toLowerCase().contains(query.toLowerCase());
      },
    );
    return ListView.separated(
      itemCount: s.length,
      itemBuilder: (context, index) {
        return SurahTileExpanded(
          index: index,
          surah: Surah(surahNumber: 2, name: '', audio: ''),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: onWhiteColor,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final s = surah.where(
      (e) {
        return e.toLowerCase().contains(query.toLowerCase());
      },
    );
    return ListView.separated(
      itemCount: s.length,
      itemBuilder: (context, index) {
        return SurahTileExpanded(
          index: index,
          surah: Surah(surahNumber: 2, name: '', audio: ''),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: onWhiteColor,
          ),
        );
      },
    );
  }
}
