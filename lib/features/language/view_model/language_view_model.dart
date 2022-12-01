import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/utils/app_error.dart';
import '../model/language_model.dart';
import '../repository/language_repositroy.dart';

class LanguageViewModel with ChangeNotifier {
  String? selectedLanguage;
  List<LanguageModel> languageModel = [];
  AppError? _fetchLanguageError;

  void onLanguageSelect(String value) {
    selectedLanguage = value;
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    BotToast.showLoading();
    var res = await LanguageRepository().languages();

    res.fold(
      (l) {
        _fetchLanguageError = l;
        BotToast.closeAllLoading();
      },
      (r) {
        languageModel = r;
        _fetchLanguageError = null;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }

  AppError? get fetchLanguageError => _fetchLanguageError;
}
