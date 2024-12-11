import '../models/owner.dart';
class Dog {
  final int? id; // Nullable id
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String distance;
  final String imageUrl;
  final String description;
  final Owner owner;

  Dog({
    this.id, // id is now optional (nullable)
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.distance,
    required this.imageUrl,
    required this.description,
    required this.owner,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      age: (json['age'] != null) ? json['age'].toDouble() : 0.0,
      gender: json['gender'] ?? '',
      color: json['color'] ?? '',
      weight: (json['weight'] != null) ? json['weight'].toDouble() : 0.0,
      distance: json['distance'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : Owner.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'color': color,
      'weight': weight,
      'distance': distance,
      'imageUrl': imageUrl,
      'description': description,
      'owner': owner.toJson(),
    };
  }
}
