import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rakhsaani/features/language/view/language_select_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      home: const LanguageSelectScreen(),
    );
  }
}
