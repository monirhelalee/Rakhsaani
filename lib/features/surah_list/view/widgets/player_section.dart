import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rakhsaani/core/utils/constant.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';

class PlayerSection extends StatelessWidget {
  const PlayerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kScaffoldBgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Arabic text',
            style: AppTextStyles.kTileTitle,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Translation',
            style: AppTextStyles.kTileTitle,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: onPrimayColor,
                  size: kDefaultIconSize,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.speaker_2,
                  color: onPrimayColor,
                  size: kDefaultIconSize,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
                trackHeight: .5, overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.white,
              min: 0,
              max: 100,
              onChanged: (double value) {},
              value: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0:00.41',
                  style: AppTextStyles.kPlayerTimerTextStyle,
                ),
                Text(
                  '0:01.31',
                  style: AppTextStyles.kPlayerTimerTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.repeat,
                  color: onPrimayColor,
                  size: 18,
                ),
              ),
              Image.asset(
                '${Urls.iconUrl}ic_navigate_before.png',
                width: 15,
                color: onPrimayColor,
              ),
              Image.asset(
                '${Urls.iconUrl}ic_play_circle.png',
                width: 50,
                color: onPrimayColor,
              ),
              Image.asset(
                '${Urls.iconUrl}ic_navigate_next.png',
                width: 15,
                color: onPrimayColor,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.shuffle,
                  color: onPrimayColor,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
