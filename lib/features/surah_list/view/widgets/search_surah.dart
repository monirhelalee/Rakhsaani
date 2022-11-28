import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../search/custom_search_deligate.dart';

class SearchSurah extends StatefulWidget {
  const SearchSurah({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchSurah> createState() => _SearchSurahState();
}

class _SearchSurahState extends State<SearchSurah> {
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SurahListViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: IconButton(
        onPressed: () {
          vm.search(value: "");
          vm.searchController.clear();
          vm.toggleSearchIcon();
        },
        icon: Icon(
          vm.isSearchOpen ? CupertinoIcons.clear : CupertinoIcons.search,
          color: onPrimayColor,
        ),
      ),
    );
  }
}
