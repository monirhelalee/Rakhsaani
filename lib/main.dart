import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/utils/colors.dart';
import 'features/detail/view_model/surah_detail_view_model.dart';
import 'features/language/view_model/language_view_model.dart';
import 'features/player/view_model/player_view_model.dart';
import 'features/splash/view/splash_screen.dart';
import 'features/surah_list/view_model/surah_list_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Transparent Status Bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageViewModel>(
          create: (context) => LanguageViewModel(),
        ),
        ChangeNotifierProvider<SurahListViewModel>(
          create: (context) => SurahListViewModel(),
        ),
        // ChangeNotifierProxyProvider<PlayerViewModel, SurahListViewModel>(
        //   create: (context) => SurahListViewModel(),
        //   update: (_, playerViewModel, data) => data!..update(playerViewModel),
        // ),
        ChangeNotifierProvider<PlayerViewModel>(
          create: (context) => PlayerViewModel(),
        ),
        ChangeNotifierProxyProvider<SurahListViewModel, SurahDetailViewModel>(
          create: (context) => SurahDetailViewModel(),
          update: (_, playerListViewModel, data) =>
              data!..update(playerListViewModel),
        ),
      ],
      child: MaterialApp(
        title: 'Rakhsaani',
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        theme: ThemeData(
          primarySwatch: primarySwatchColor,
          primaryColor: const Color(0xff121314),
          brightness: Brightness.light,
          fontFamily: 'Optima',
          // dividerColor: Colors.black12,
          // scaffoldBackgroundColor: const Color(0xFF121314),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
