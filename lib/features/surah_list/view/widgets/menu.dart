import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/urls.dart';
import '../../../about/view/about_rakhsaani.dart';
import '../../../bookmarks/view/bookmarks_screen.dart';
import '../../../language/view/menu_select_language_screen.dart';
import '../surah_list_screen.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: primaryColor,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        const PopupMenuItem<String>(
          value: 'language',
          child: PopupMenuRow(
            text: 'Language',
            icon: 'ic_langues.png',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'surah_list',
          child: PopupMenuRow(
            text: 'Surah List',
            icon: 'ic_surah_list.png',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'bookmarks',
          child: PopupMenuRow(
            text: 'Bookmarks',
            icon: 'ic_bookmarks.png',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'about_rakhsaani',
          child: PopupMenuRow(
            text: 'About Rakhsaani',
            icon: 'ic_about.png',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'privacy_policy',
          child: PopupMenuRow(
            text: 'Privacy Policy',
            icon: 'ic_privacy.png',
          ),
        ),
        // const PopupMenuItem<String>(
        //   value: 'rating',
        //   child: PopupMenuRow(
        //     text: 'Rating',
        //     icon: 'ic_rating.png',
        //   ),
        // ),
        // const PopupMenuItem<String>(
        //   value: 'feedback',
        //   child: PopupMenuRow(
        //     text: 'Feedback',
        //     icon: 'ic_feedback.png',
        //   ),
        // ),
        // const PopupMenuItem<String>(
        //   value: 'share',
        //   child: PopupMenuRow(
        //     text: 'Share',
        //     icon: 'ic_share.png',
        //   ),
        // ),
        // const PopupMenuItem<String>(
        //   value: 'settings',
        //   child: PopupMenuRow(
        //     text: 'Settings',
        //     icon: 'ic_setting.png',
        //   ),
        // ),
        // const PopupMenuItem<String>(
        //   value: 'help',
        //   child: PopupMenuRow(
        //     text: 'Help',
        //     icon: 'ic_help.png',
        //   ),
        // ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'language':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const MenuSelectLanguageScreen()),
            );
            break;
          case 'about_rakhsaani':
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AboutRakhsaani()),
            );
            break;
          case 'surah_list':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SurahListScreen()),
            );
            break;
          case 'bookmarks':
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BookmarksScreen()),
            );
            break;
          case 'privacy_policy':
            launchUrl(
              Uri.parse(Urls.privacyPolicy),
            );
            break;
          case 'help':
            launchUrl(
              Uri(
                scheme: 'mailto',
                path: Urls.helpEmail,
              ),
            );
            break;
          default:
        }
      },
      child: const Padding(
        padding: EdgeInsets.only(right: kDefaultPadding),
        child: Icon(
          Icons.menu,
          color: onPrimayColor,
        ),
      ),
    );
  }
}

class PopupMenuRow extends StatelessWidget {
  const PopupMenuRow({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: AppTextStyles.kTileTitle,
        ),
        const SizedBox(
          width: 25,
        ),
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            '$iconUrl$icon',
          ),
        )
      ],
    );
  }
}
