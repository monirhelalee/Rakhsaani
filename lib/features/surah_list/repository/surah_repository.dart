import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../../core/utils/urls.dart';

class TicketRepository {
  Future<Either<String, String>> myTickets() async {
    try {
      final _response = await http.get(Uri.parse(Urls.surahList));

      if (_response.statusCode == 200) {
        // SurahModel data = SurahModelFromJson(_response.body);
        // return Right(data);
        return right('');
      } else {
        return const Left('');
      }
    } on SocketException {
      return left('');
    } catch (e) {
      return left('');
    }
  }
}
