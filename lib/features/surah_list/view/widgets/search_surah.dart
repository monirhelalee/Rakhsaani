import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../search/custom_search_deligate.dart';

class SearchSurah extends StatelessWidget {
  const SearchSurah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SurahListViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(vm),
          );
        },
        icon: const Icon(
          CupertinoIcons.search,
          color: onPrimayColor,
        ),
      ),
    );
  }
}
