import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../../core/utils/app_error.dart';
import '../../../core/utils/urls.dart';
import '../model/language_model.dart';

class LanguageRepository {
  Future<Either<AppError, List<LanguageModel>>> languages() async {
    try {
      final response = await http.get(Uri.parse(Urls.baseUrl + Urls.language));
      log(response.body);
      if (response.statusCode == 200) {
        List<LanguageModel> data = languageModelFromJson(response.body);
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
