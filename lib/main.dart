import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/features/language/view/language_select_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rakhsaani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
        primaryColor: const Color(0xff121314),
        useMaterial3: true,
        brightness: Brightness.light,
        // dividerColor: Colors.black12,
        // scaffoldBackgroundColor: const Color(0xFF121314),
      ),
      home: const LanguageSelectScreen(),
    );
  }
}
