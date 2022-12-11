import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/asset_path.dart';
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
        elevation: 1,
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
                    'Select Language',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const MenuRadioButtonSection(),
                ],
              ),
            ),
    );
  }
}
