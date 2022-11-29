import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/helpers/database_helper.dart';
import 'package:rakhsaani/features/bookmarks/model/bookmark_model.dart';
import '../../../core/utils/app_error.dart';
import '../model/surah.dart';
import '../repository/surah_repository.dart';

class SurahListViewModel with ChangeNotifier {
  static SurahListViewModel read(BuildContext context) =>
      context.read<SurahListViewModel>();

  static SurahListViewModel watch(BuildContext context) =>
      context.watch<SurahListViewModel>();

  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Bookmark> _bookmarks = [];
  List<Surah> _surahList = [];
  List<Surah> _surahSearchList = [];
  AppError? _fetchSurahError;
  Surah? selectedSurah;
  int? _selectedSurahNumber;
  bool isSearchOpen = false;
  TextEditingController searchController = TextEditingController();

  // late PlayerViewModel _playerViewModel;

  // void update(PlayerViewModel playerViewModel) {
  //   _playerViewModel = playerViewModel;
  //   // notifyListeners();
  // }
  toggleSearchIcon() {
    isSearchOpen = !isSearchOpen;
    notifyListeners();
  }

  search({required String value}) {
    _surahSearchList = _surahList;
    if (value.isNotEmpty) {
      _surahSearchList = _surahSearchList.where((element) {
        return element.surah!.name!.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  set selectedSurahNumber(int? i) {
    _selectedSurahNumber = i;
    notifyListeners();
  }

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
        _surahSearchList = r;
        _fetchSurahError = null;
        BotToast.closeAllLoading();
        notifyListeners();
      },
    );
  }

  void tapSurah(int surahNumber) {
    _selectedSurahNumber = surahNumber;
    notifyListeners();
  }

  prev() {
    // Check if it is the first surah
    if (_selectedSurahNumber != 1) {
      _selectedSurahNumber = _selectedSurahNumber! - 1;
      notifyListeners();
    }
  }

  next() {
    // Check if it is the last surah
    if (_selectedSurahNumber != 2) {
      _selectedSurahNumber = _selectedSurahNumber! + 1;
      notifyListeners();
    }
  }

  Surah getSurahByNumber(int num) {
    Surah s =
        _surahList.firstWhere((element) => element.surah?.surahNumber == num);
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

  addBookmarks(int surahNumber) {
    final bookmark = Bookmark(
      id: surahNumber,
      surahNumber: surahNumber,
    );
    databaseHelper.addBookmark(bookmark);
    fetchBookmarks();
  }

  void deleteBookmark(int? surahNumber) {
    databaseHelper.deleteBookmark(surahNumber!);
    fetchBookmarks();
  }

  List<Surah> getBookmarkedSurah() {
    List<int?> bookMarkSurahNumber = _bookmarks.map((e) => e.surahNumber).toList();
    List<Surah> bookmarkedSurah = _surahList
        .where((element) => bookMarkSurahNumber.contains(element.surah?.surahNumber))
        .toList();
    return bookmarkedSurah;
  }

  // Getters
  List<Surah> get surahList => _surahList;
  List<Surah> get surahSearchList => _surahSearchList;
  int? get selectedSurahNumber => _selectedSurahNumber;
  AppError? get fetchSurahError => _fetchSurahError;
  List<Bookmark> get bookmarks => [..._bookmarks];
}
