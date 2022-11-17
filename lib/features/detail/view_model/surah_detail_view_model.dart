import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah_detail.dart';
import '../repository/surah_detail_repository.dart';

class SurahDetailViewModel with ChangeNotifier {
  SurahDetail? _surahDetailModel;
  AppError? _surahDetailError;

  Future<void> fetchSurahDetail() async {
    BotToast.showLoading();
    var res = await SurahDetailRepository().fetchSurahDetail(2);
    res.fold(
      (l) {
        _surahDetailError = l;
        BotToast.closeAllLoading();
        notifyListeners();
      },
      (r) {
        _surahDetailModel = r;
        _surahDetailError = null;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }

  //  get verseAndTime => _surahDetailModel!.verseAndTime;

  SurahDetail? get surahDetailModel => _surahDetailModel;
  AppError? get surahDetailError => _surahDetailError;
}
