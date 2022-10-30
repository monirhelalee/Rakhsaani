import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/features/language/view/language_select_screen.dart';
import 'package:rakhsaani/features/language/view_model.dart/language_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      ],
      child: MaterialApp(
        title: 'Rakhsaani',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primarySwatchColor,
          primaryColor: const Color(0xff121314),
          brightness: Brightness.light,
          // dividerColor: Colors.black12,
          // scaffoldBackgroundColor: const Color(0xFF121314),
        ),
        home: const LanguageSelectScreen(),
      ),
    );
  }
}
