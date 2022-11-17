import 'dart:convert';

SurahDetail surahDetailFromJson(String str) => SurahDetail.fromJson(json.decode(str));

String surahDetailToJson(SurahDetail data) => json.encode(data.toJson());

class SurahDetail {
    SurahDetail({
       required this.verse,
       required this.timeIn,
       required this.timeOut,
       required this.text,
       required this.verseAndTime,
    });

    String verse;
    String timeIn;
    String timeOut;
    String text;
    List<SurahDetail>? verseAndTime;

    factory SurahDetail.fromJson(Map<String, dynamic> json) => SurahDetail(
        verse: json["verse"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        text: json["text"],
        verseAndTime: json["verse_and_time"] == null ? null : List<SurahDetail>.from(json["verse_and_time"].map((x) => SurahDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "verse": verse,
        "time_in": timeIn,
        "time_out": timeOut,
        "text": text,
        "verse_and_time": verseAndTime == null ? null : List<dynamic>.from(verseAndTime!.map((x) => x.toJson())),
    };
}
