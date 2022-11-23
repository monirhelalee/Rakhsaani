import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/bookmarks/view/widgets/bookmark_tile.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';

import '../../../core/utils/colors.dart';
import '../../surah_list/view/widgets/menu.dart';
import '../../surah_list/view/widgets/search_surah.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurahListViewModel>().fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SurahListViewModel>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bookmarks'),
        leading: const SearchSurah(),
        actions: const [
          Menu(),
        ],
      ),
      body: vm.bookmarks.isEmpty
          ? const Center(
              child: Text('No Bookmarks Added'),
            )
          : ListView.separated(
              itemCount: vm.getBookmarkedSurah().length,
              itemBuilder: (context, index) => BookmarkTile(
                index: index,
                surah: vm.getBookmarkedSurah()[index],
              ),
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
