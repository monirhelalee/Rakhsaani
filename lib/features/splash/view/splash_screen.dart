import 'package:flutter/material.dart';
import '../../../core/helpers/storage_manager.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/urls.dart';
import '../../language/view/language_select_screen.dart';
import '../../surah_list/view/surah_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? isFirstTime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setVal();
    });
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => isFirstTime == null
                ? const LanguageSelectScreen()
                : const SurahListScreen(),
          ),
        );
      },
    );
  }

  _setVal() async {
    isFirstTime = await StorageManager().getKey('isFirstTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('${Urls.imageUrl}ic_launcher_foreground.png'),
            ],
          ),
          const Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'www.rakhsaanitrust.org',
                style: AppTextStyles.kWebsiteText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
