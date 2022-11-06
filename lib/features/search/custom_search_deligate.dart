import 'dart:developer';

import 'package:flutter/material.dart';

import '../surah_list/view/widgets/surah_tile_expanded.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

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
    final surah = List.generate(114, (index) => 'Surah ${index + 1}').where(
      (e) {
        log(e);
        return e.toLowerCase().contains(query.toLowerCase());
      },
    );
    return ListView.builder(
      itemCount: surah.length,
      itemBuilder: (context, index) {
        return SurahTileExpanded(index: index);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
