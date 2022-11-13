import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
  Surah({
    required this.surahNumber,
    required this.name,
    required this.audio,
  });

  int surahNumber;
  String name;
  String audio;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        surahNumber: json["surah_number"],
        name: json["name"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "name": name,
        "audio": audio,
      };
}
