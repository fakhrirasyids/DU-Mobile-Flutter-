import 'dart:convert';

class TourismPlace {
  int id;
  String name;
  String location;
  String description;
  String openDays;
  String openTime;
  String ticketPrice;
  String imageAsset;
  List<String> imageUrls;
  String createdAt;
  String updatedAt;
  bool isFavorite;
  List<Map<String, String>> comments;
  TourismPlace({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    List<Map<String, String>>? comments,
  }) : comments = comments ?? [];

  factory TourismPlace.fromJson(Map<String, dynamic> json) {
    return TourismPlace(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      openDays: json['open_days'],
      openTime: json['open_time'],
      ticketPrice: json['ticket_price'],
      imageAsset: json['image_asset'],
      imageUrls: List<String>.from(jsonDecode(json['image_urls'])),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'location': location,
//       'description': description,
//       'open_days': openDays,
//       'open_time': openTime,
//       'ticket_price': ticketPrice,
//       'image_asset': imageAsset,
//       'image_urls': jsonEncode(imageUrls),
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'is_favorite': isFavorite,
//     };
// }
}
