// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
  Surah({
    required this.id,
    required this.duration,
    required this.surah,
    required this.language,
  });

  int id;
  String duration;
  SurahClass surah;
  Language language;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        id: json["id"],
        duration: json["duration"],
        surah: SurahClass.fromJson(json["surah"]),
        language: Language.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "surah": surah.toJson(),
        "language": language.toJson(),
      };
}

class Language {
  Language({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SurahClass {
  SurahClass({
    required this.surahNumber,
    required this.name,
    required this.audio,
  });

  int surahNumber;
  String name;
  String audio;

  factory SurahClass.fromJson(Map<String, dynamic> json) => SurahClass(
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
