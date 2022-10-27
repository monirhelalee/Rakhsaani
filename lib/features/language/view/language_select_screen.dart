import 'package:flutter/material.dart';

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
            const FlutterLogo(),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Al-Quran',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                child: Column(
                  children: ['Bengali', 'English', 'Spanish']
                      .map(
                        (e) => ListTile(
                          title: Text(e),
                          trailing: Radio(
                            value: false,
                            groupValue: '',
                            onChanged: (s) {},
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
