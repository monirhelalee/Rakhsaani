import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../surah_list/view_model/surah_list_view_model.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah_detail.dart';
import '../repository/surah_detail_repository.dart';

class SurahDetailViewModel with ChangeNotifier {
  SurahDetail? _surahDetailModel;
  AppError? _surahDetailError;

  late SurahListViewModel _surahListViewModel;

  void update(SurahListViewModel surahListViewModel) {
    _surahListViewModel = surahListViewModel;
    log(_surahListViewModel.selectedSurahNumber.toString());
    // notifyListeners();
  }

  Future<void> fetchSurahDetail({required int surahNumber}) async {
    BotToast.showLoading();
    var res = await SurahDetailRepository().fetchSurahDetail(surahNumber);
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

  String syncTextWithTime(time) {
    String? text = _surahDetailModel!.verseAndTime
        .firstWhere((element) => element.timeIn == time)
        .text;

    return text;
  }

  SurahDetail? get surahDetailModel => _surahDetailModel;
  AppError? get surahDetailError => _surahDetailError;
  String get appBarTitle => _surahDetailModel!.name;
}
