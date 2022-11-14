import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../../core/utils/app_error.dart';
import '../../../core/utils/urls.dart';
import '../model/surah.dart';

class SurahRepository {
  Future<Either<AppError, List<Surah>>> fetchSurahList() async {
    String selectedLanguage = 'English';
    try {
      final response = await http
          .get(Uri.parse(Urls.baseUrl + Urls.surahList + selectedLanguage));

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
