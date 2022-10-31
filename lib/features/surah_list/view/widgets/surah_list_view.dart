import 'package:flutter/material.dart';
import 'separator.dart';
import 'surah_tile.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 114,
      itemBuilder: (context, index) {
        return SurahTile(
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const Separator();
      },
    );
  }
}
