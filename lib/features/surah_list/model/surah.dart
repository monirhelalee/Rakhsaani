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
    this.id,
    this.duration,
    this.surah,
    this.language,
  });

  int? id;
  String? duration;
  SurahClass? surah;
  Language? language;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        id: json["id"] == null ? null : json["id"],
        duration: json["duration"] == null ? null : json["duration"],
        surah:
            json["surah"] == null ? null : SurahClass.fromJson(json["surah"]),
        language: json["language"] == null
            ? null
            : Language.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "duration": duration == null ? null : duration,
        "surah": surah == null ? null : surah?.toJson(),
        "language": language == null ? null : language?.toJson(),
      };
}

class Language {
  Language({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class SurahClass {
  SurahClass({
    this.surahNumber,
    this.name,
  });

  int? surahNumber;
  String? name;

  factory SurahClass.fromJson(Map<String, dynamic> json) => SurahClass(
        surahNumber: json["surah_number"] == null ? null : json["surah_number"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber == null ? null : surahNumber,
        "name": name == null ? null : name,
      };
}
