// To parse this JSON data, do
//
//     final allPlacesModels = allPlacesModelsFromJson(jsonString);

import 'dart:convert';

List<AllPlacesModels> allPlacesModelsFromJson(String str) =>
    List<AllPlacesModels>.from(
        json.decode(str).map((x) => AllPlacesModels.fromJson(x)));

String allPlacesModelsToJson(List<AllPlacesModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPlacesModels {
  int id;
  String name;
  String address;
  String latitude;
  String longitude;
  String description;
  String image;
  Title title;

  AllPlacesModels({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
    required this.title,
  });

  factory AllPlacesModels.fromJson(Map<String, dynamic> json) =>
      AllPlacesModels(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        description: json["description"],
        image: json["image"],
        title: titleValues.map[json["title"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "image": image,
        "title": titleValues.reverse[title],
      };
}

enum Title { DURBAR_SQUARE, MONASTERY, TEMPLE, ADVENTURE, PARK, LOCAL }

final titleValues = EnumValues({
  "durbar square": Title.DURBAR_SQUARE,
  "monastery": Title.MONASTERY,
  "temple": Title.TEMPLE,
  "adventure": Title.ADVENTURE,
  "park": Title.PARK,
  "local": Title.LOCAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
