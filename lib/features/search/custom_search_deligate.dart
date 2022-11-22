import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../surah_list/view/widgets/surah_tile_expanded.dart';
import '../surah_list/view_model/surah_list_view_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SurahListViewModel surahListViewModel;
  CustomSearchDelegate(this.surahListViewModel);

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
    final s = surahListViewModel.surahList.where(
      (e) {
        return e.surah.name.toLowerCase().contains(query.toLowerCase());
      },
    );
    return ListView.separated(
      itemCount: s.length,
      itemBuilder: (context, index) {
        return SurahTileExpanded(index: index, surah: s.elementAt(index));
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
    final surahList = surahListViewModel.surahList.where(
      (e) {
        return e.surah.name.toLowerCase().contains(query.toLowerCase());
      },
    );
    return ListView.separated(
      itemCount: surahList.length,
      itemBuilder: (context, index) {
        return SurahTileExpanded(
            index: index, surah: surahList.elementAt(index));
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
