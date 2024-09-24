import 'dart:convert';

class KeywordsList {
  List<Keywords> keywords;

  KeywordsList({
    required this.keywords,
  });

  factory KeywordsList.fromRawJson(String str) => KeywordsList.fromJson(json.decode(str));

  factory KeywordsList.fromJson(Map<String, dynamic> json) => KeywordsList(
        keywords: List<Keywords>.from(json["keywords"].map((x) => Keywords.fromJson(x)))
      );
}

class Keywords {
  int id;
  String name;

  Keywords({
    required this.id,
    required this.name,
  });

  factory Keywords.fromRawJson(String str) => Keywords.fromJson(json.decode(str));

  factory Keywords.fromJson(Map<String, dynamic> json) => Keywords(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );
}