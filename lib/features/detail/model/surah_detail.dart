// To parse this JSON data, do
//
//     final surahDetail = surahDetailFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

SurahDetail surahDetailFromJson(String str) =>
    SurahDetail.fromJson(json.decode(str));

String surahDetailToJson(SurahDetail data) => json.encode(data.toJson());

class SurahDetail {
  SurahDetail({
    required this.surahNumber,
    required this.name,
    required this.audio,
    required this.verseAndTime,
  });

  int surahNumber;
  String name;
  String audio;
  List<VerseAndTime> verseAndTime;

  factory SurahDetail.fromJson(Map<String, dynamic> json) => SurahDetail(
        surahNumber: json["surah_number"],
        name: json["name"],
        audio: json["audio"],
        verseAndTime: List<VerseAndTime>.from(
            json["verse_and_time"].map((x) => VerseAndTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "name": name,
        "audio": audio,
        "verse_and_time":
            List<dynamic>.from(verseAndTime.map((x) => x.toJson())),
      };
}

class VerseAndTime {
  VerseAndTime({
    required this.verse,
    required this.timeIn,
    required this.timeOut,
    required this.text,
  });

  String verse;
  String timeIn;
  String timeOut;
  String text;

  factory VerseAndTime.fromJson(Map<String, dynamic> json) => VerseAndTime(
        verse: json["verse"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "verse": verse,
        "time_in": timeIn,
        "time_out": timeOut,
        "text": text,
      };
}
