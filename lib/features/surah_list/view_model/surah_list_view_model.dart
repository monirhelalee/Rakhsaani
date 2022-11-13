import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah.dart';
import '../repository/surah_repository.dart';

class SurahListViewModel with ChangeNotifier {
  bool isPlayerExpanded = false;
  List<Surah> _surahList = [];
  AppError? _fetchSurahError;

  void playSurah() {
    isPlayerExpanded = true;
    notifyListeners();
  }

  void stopPlaying() {
    log('message');
    isPlayerExpanded = false;
    notifyListeners();
  }

  Future<void> fetchSurahList() async {
    BotToast.showLoading();
    var res = await SurahRepository().fetchSurahList();
    res.fold(
      (l) {
        _fetchSurahError = l;
        BotToast.closeAllLoading();
      },
      (r) {
        _surahList = r;
        _fetchSurahError = null;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }

  List<Surah> get surahList => _surahList;
  AppError? get fetchSurahError => _fetchSurahError;
}
