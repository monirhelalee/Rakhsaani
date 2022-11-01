import 'package:flutter/cupertino.dart';

class SurahListViewModel with ChangeNotifier{
  bool isPlayerExpanded = false;

  void playSurah(){
    isPlayerExpanded = true;
    notifyListeners();
  }
}