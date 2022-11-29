import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../surah_list/view/widgets/player_section.dart';
import '../../surah_list/view/widgets/surah_list_view_expanded.dart';
import '../view_model/surah_detail_view_model.dart';
import 'widget/detail_menu.dart';

class DetailScreen extends StatefulWidget {
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
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // @override
  // void dispose() {
  //   context.read<PlayerViewModel>().player.stop();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<SurahDetailViewModel>().appBarTitle),
        actions: const [
          DetailMenu(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PlayerSection(
              surahNumber: widget.surahNumber,
            ),
          ),
          const Expanded(flex: 1, child: SurahListViewExpanded()),
        ],
      ),
    );
  }
}
