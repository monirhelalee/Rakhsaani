import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../model/surah_detail.dart';
import '../../../core/helpers/storage_manager.dart';
import '../../../core/utils/api_client.dart';
import '../../../core/utils/app_error.dart';
import '../../../core/utils/urls.dart';

class SurahDetailRepository {
  Future<Either<AppError, SurahDetail>> fetchSurahDetail(
      var surahNumber) async {
    String selectedLanguage = await StorageManager.getKey('lang') ?? '';
    try {
      var response = await ApiClient()
          .getRequest("${Urls.surahList}$surahNumber/$selectedLanguage");
      log("${Urls.surahList}$surahNumber/$selectedLanguage");
      log("surah details ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> _map = jsonDecode(utf8.decode(response.bodyBytes));
        SurahDetail data = SurahDetail.fromJson(_map);
        return Right(data);
      } else {
        return const Left(AppError.networkError);
      }
    } on SocketException {
      return left(AppError.networkError);
    } catch (e) {
      return left(AppError.networkError);
    }
  }
}
