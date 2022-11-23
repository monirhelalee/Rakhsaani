import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:rakhsaani/core/helpers/database_helper.dart';
import 'package:rakhsaani/features/bookmarks/model/bookmark_model.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah.dart';
import '../repository/surah_repository.dart';

class SurahListViewModel with ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Bookmark> _bookmarks = [];
  List<Surah> _surahList = [];
  AppError? _fetchSurahError;
  Surah? selectedSurah;
  int? selectedSurahNumber;

  // late PlayerViewModel _playerViewModel;

  // void update(PlayerViewModel playerViewModel) {
  //   _playerViewModel = playerViewModel;
  //   // notifyListeners();
  // }

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

  void tapSurah(int surahNumber) {
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

  // Local DB
  fetchBookmarks() async {
    BotToast.showLoading();
    var data = await databaseHelper.getBookmarks();
    _bookmarks = data;
    BotToast.closeAllLoading();
    notifyListeners();
  }

  addBookmarks(int id, int surahNumber) {
    final bookmark = Bookmark(
      id: id,
      surahNumber: surahNumber,
    );
    databaseHelper.addBookmark(bookmark);
    fetchBookmarks();
  }

  void deleteBookmark(int? id) {
    databaseHelper.deleteBookmark(id!);
    fetchBookmarks();
  }

  List<Surah> getBookmarkedSurah() {
    List<int?> bookMarkSurahNumber = _bookmarks.map((e) => e.id).toList();
    List<Surah> bookmarkedSurah = _surahList
        .where((element) => bookMarkSurahNumber.contains(element.id))
        .toList();
    return bookmarkedSurah;
  }

  // Getters
  List<Surah> get surahList => _surahList;
  AppError? get fetchSurahError => _fetchSurahError;
  List<Bookmark> get bookmarks => [..._bookmarks];
}
