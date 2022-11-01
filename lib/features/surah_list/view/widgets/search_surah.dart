import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';

class SearchSurah extends StatelessWidget {
  const SearchSurah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.search,
          color: onPrimayColor,
        ),
      ),
    );
  }
}
