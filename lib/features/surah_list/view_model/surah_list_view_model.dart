import 'package:flutter/cupertino.dart';

class SurahListViewModel with ChangeNotifier{
  bool isPlayerExpanded = true;

  void playSurah(){
    isPlayerExpanded = true;
    notifyListeners();
  }
}