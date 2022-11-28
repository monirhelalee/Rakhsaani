import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../surah_list/view/widgets/player_section.dart';
import '../../surah_list/view/widgets/surah_list_view_expanded.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.index,
    required this.name,
    required this.surahNumber,
  });

  final int index;
  final String name;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Expanded(
            child: PlayerSection(
              surahNumber: surahNumber,
            ),
          ),
          const Expanded(child: SurahListViewExpanded()),
        ],
      ),
    );
  }
}
