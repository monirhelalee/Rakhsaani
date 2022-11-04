import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/splash/view/splash_screen.dart';
import 'core/utils/colors.dart';
import 'features/language/view/language_select_screen.dart';
import 'features/language/view_model/language_view_model.dart';
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
      ],
      child: MaterialApp(
        title: 'Rakhsaani',
        debugShowCheckedModeBanner: false,
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
