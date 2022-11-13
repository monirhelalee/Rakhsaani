import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../error_screen/error_screen.dart';
import '../view_model/language_view_model.dart';
import 'widgets/menu_radio_button_section.dart';

class MenuSelectLanguageScreen extends StatefulWidget {
  const MenuSelectLanguageScreen({Key? key}) : super(key: key);

  @override
  State<MenuSelectLanguageScreen> createState() =>
      _MenuSelectLanguageScreenState();
}

class _MenuSelectLanguageScreenState extends State<MenuSelectLanguageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageViewModel>().loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        centerTitle: true,
      ),
      body: context.read<LanguageViewModel>().fetchLanguageError != null
          ? const ErrorScreen()
          : Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Select Language',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MenuRadioButtonSection(),
                ],
              ),
            ),
    );
  }
}
