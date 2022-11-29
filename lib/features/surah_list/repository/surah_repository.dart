import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:rakhsaani/core/helpers/storage_manager.dart';
import '../../../core/utils/api_client.dart';
import '../../../core/utils/app_error.dart';
import '../../../core/utils/urls.dart';
import '../model/surah.dart';

class SurahRepository {
  Future<Either<AppError, List<Surah>>> fetchSurahList() async {
    String selectedLanguage = await StorageManager.getKey('lang') ?? '';
    try {
      var response =
          await ApiClient().getRequest("${Urls.surahList}$selectedLanguage");
      log("surah details ${response.body}");
      if (response.statusCode == 200) {
        List<Surah> data = surahFromJson(response.body);
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
