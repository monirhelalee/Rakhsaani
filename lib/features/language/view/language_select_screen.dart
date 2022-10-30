import 'package:flutter/material.dart';
import 'widgets/radio_button_section.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            FlutterLogo(),
            SizedBox(
              height: 40,
            ),
            Text(
              'Al-Quran',
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RadioButtonSection(),
          ],
        ),
      ),
    );
  }
}
