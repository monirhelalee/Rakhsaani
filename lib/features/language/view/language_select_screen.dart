import 'package:flutter/material.dart';
import 'package:rakhsaani/core/utils/urls.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(
                '${Urls.imageUrl}ic_bismillah_vector.png',
                width: 200,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Al-Quran',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Resagnicto',
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const RadioButtonSection(),
          ],
        ),
      ),
    );
  }
}
