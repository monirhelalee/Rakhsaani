import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../error_screen/error_screen.dart';
import '../../../core/utils/asset_path.dart';
import '../view_model/language_view_model.dart';
import 'widgets/radio_button_section.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageViewModel>().loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.read<LanguageViewModel>().fetchLanguageError != null
          ? const ErrorScreen()
          : Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Image.asset(
                      '${imageUrl}ic_bismillah_vector.png',
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
