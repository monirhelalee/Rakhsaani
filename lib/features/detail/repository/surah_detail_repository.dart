import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:rakhsaani/features/detail/model/surah_detail.dart';
import '../../../core/utils/app_error.dart';
import '../../../core/utils/urls.dart';

class SurahDetailRepository {
  Future<Either<AppError, SurahDetail>> fetchSurahDetail(var surahNumber) async {
    String selectedLanguage = 'English';
    try {
      final response = await http
          .get(Uri.parse('${Urls.surahDetail}$surahNumber/$selectedLanguage'));
      log(response.body);
      if (response.statusCode == 200) {
        SurahDetail data = surahDetailFromJson(response.body);
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
