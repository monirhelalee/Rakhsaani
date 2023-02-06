import 'package:flutter/material.dart';
import '../../../core/helpers/storage_manager.dart';
import '../../../core/utils/asset_path.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
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
      const Duration(seconds: 2),
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
    isFirstTime = await StorageManager.getKey('isFirstTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                '${iconUrl}logo_croped.png',
                height: 130,
              ),
            ],
          ),
          const Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'www.rakhsaani.org',
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
