import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import '../model/language_model.dart';
import '../repository/language_repositroy.dart';

class LanguageViewModel with ChangeNotifier {
  String? selectedLanguage;
  List<LanguageModel>? languageModel;

  void onLanguageSelect(String value) {
    selectedLanguage = value;
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    BotToast.showLoading();
    var res = await LanguageRepository().languages();

    res.fold(
      (l) {
        BotToast.closeAllLoading();
      },
      (r) {
        languageModel = r;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }
}
