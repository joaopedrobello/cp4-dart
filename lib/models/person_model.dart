import 'dart:convert';

import 'package:movie_app/common/utils.dart';

class Person {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  String birthday;
  String deathday;
  String gender;
  String homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  Person(
      {required this.adult,
      required this.alsoKnownAs,
      required this.biography,
      required this.birthday,
      required this.deathday,
      required this.gender,
      required this.homepage,
      required this.id,
      required this.imdbId,
      required this.knownForDepartment,
      required this.name,
      required this.placeOfBirth,
      required this.popularity,
      required this.profilePath});

  factory Person.fromRawJson(String str) =>
      Person.fromJson(json.decode(str));

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(
        adult: json['adult'] ?? false,
        alsoKnownAs: json['also_known_as'].cast<String>() ?? "",
        biography: json['biography'] ?? "",
        birthday: json['birthday'] ?? "",
        deathday: json['deathday'] ?? "",
        gender: getGender(json["gender"] ?? '0'),
        homepage: json['homepage'] ?? "",
        id: json['id'],
        imdbId: json['imdb_id'] ?? "",
        knownForDepartment: json['known_for_department'] ?? "",
        name: json['name'] ?? "",
        placeOfBirth: json['place_of_birth'] ?? "",
        popularity: json['popularity'],
        profilePath: json['profile_path'] ?? "",
      );
}
