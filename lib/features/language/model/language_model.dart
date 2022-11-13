import 'dart:convert';

List<LanguageModel> languageModelFromJson(String str) =>
    List<LanguageModel>.from(
        json.decode(str).map((x) => LanguageModel.fromJson(x)));

String languageModelToJson(List<LanguageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageModel {
  LanguageModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
