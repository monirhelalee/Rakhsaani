import 'package:flutter/material.dart';

class SurahTile extends StatelessWidget {
  const SurahTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        children: [
          Text('${index + 1}'),
          const SizedBox(width: 25),
          Text('Surah ${index + 1}'),
          const Spacer(),
          const Text('0:01:31'),
          const SizedBox(width: 25),
          const Icon(Icons.play_circle_outline),
        ],
      ),
    );
  }
}