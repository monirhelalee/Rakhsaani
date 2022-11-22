import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah.dart';
import '../repository/surah_repository.dart';

class SurahListViewModel with ChangeNotifier {
  List<Surah> _surahList = [];
  AppError? _fetchSurahError;
  Surah? selectedSurah;
  int? selectedSurahNumber;

  Future<void> fetchSurahList() async {
    BotToast.showLoading();
    var res = await SurahRepository().fetchSurahList();
    res.fold(
      (l) {
        _fetchSurahError = l;
        BotToast.closeAllLoading();
        notifyListeners();
      },
      (r) {
        _surahList = r;
        _fetchSurahError = null;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }

  void tapSurah(int surahNumber){
    selectedSurahNumber = surahNumber;
    notifyListeners();
  }

  prev() {
    // Check if it is the first surah
    if (selectedSurahNumber != 1) {
      selectedSurahNumber = selectedSurahNumber! - 1;
      notifyListeners();
    }
  }

  next() {
    // Check if it is the last surah
    if (selectedSurahNumber != 2) {
      selectedSurahNumber = selectedSurahNumber! + 1;
      notifyListeners();
    }
  }

  Surah getSurahByNumber(int num) {
    Surah s =
        _surahList.firstWhere((element) => element.surah.surahNumber == num);
    selectedSurah = s;
    notifyListeners();
    return s;
  }

  List<Surah> get surahList => _surahList;
  AppError? get fetchSurahError => _fetchSurahError;
}
