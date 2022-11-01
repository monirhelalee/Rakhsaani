import 'package:flutter/material.dart';
import 'surah_tile_expanded.dart';

class SurahListViewExpanded extends StatelessWidget {
  const SurahListViewExpanded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 114,
      itemBuilder: (context, index) {
        return SurahTileExpanded(
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: Colors.grey,
          ),
        );
        ;
      },
    );
  }
}
