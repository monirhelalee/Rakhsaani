import 'dart:developer';

import 'package:flutter/foundation.dart';

class SurahListViewModel with ChangeNotifier {
  bool isPlayerExpanded = false;

  void playSurah() {
    isPlayerExpanded = true;
    notifyListeners();
  }

  void stopPlaying() {
    log('message');
    isPlayerExpanded = false;
    notifyListeners();
  }
}
