import 'package:flutter/cupertino.dart';

class LanguageViewModel with ChangeNotifier {
  String? selectedLanguage;

  void onLanguageSelect(String value) {
    selectedLanguage = value;
    notifyListeners();
  }
}
