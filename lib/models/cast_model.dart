import 'dart:convert';
import 'package:movie_app/common/utils.dart';

class Cast {
  List<CastDetail> actors;

  Cast({
    required this.actors,
  });

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        actors: List<CastDetail>.from(json["cast"].map((x) => CastDetail.fromJson(x))),
      );
}

class CastDetail {
  bool adult;
  String gender;
  int id;
  String department;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  CastDetail({
    required this.adult,
    required this.gender,
    required this.id,
    required this.department,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastDetail.fromRawJson(String str) =>
      CastDetail.fromJson(json.decode(str));

  factory CastDetail.fromJson(Map<String, dynamic> json) =>
      CastDetail(
        adult: json["adult"] ?? false,
        gender: getGender(json["gender"] ?? '0'),
        id: json["id"],
        department: json["known_for_department"] ?? "",
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        popularity: json["popularity"] ?? '0',
        profilePath: json["profile_path"] ?? "",
        castId: json["cast_id"] ?? 0,
        character: json["character"] ?? "",
        creditId: json["credit_id"] ?? "",
        order: json["order"] ?? 0
      );
}
