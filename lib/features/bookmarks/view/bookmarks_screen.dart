import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rakhsaani/features/bookmarks/view/widgets/bookmark_tile.dart';

import '../../../core/utils/colors.dart';
import '../../surah_list/view/widgets/menu.dart';
import '../../surah_list/view/widgets/search_surah.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bookmarks'),
        leading: const SearchSurah(),
        actions: const [
          Menu(),
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) => BookmarkTile(index: index),
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: onWhiteColor,
            ),
          );
        },
      ),
    );
  }
}
