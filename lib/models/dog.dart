import 'owner.dart'; // Assurez-vous d'importer le modèle Owner

class Dog {
  final int id;
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
    required this.id,
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

  // Méthode fromJson avec vérification de nullité
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] ?? 0, // Fournir une valeur par défaut si id est null
      name: json['name'] ?? '', // Fournir une valeur vide si name est null
      age: (json['age'] != null) ? json['age'].toDouble() : 0.0, // Vérifier si 'age' n'est pas null
      gender: json['gender'] ?? '', // Fournir une valeur vide si gender est null
      color: json['color'] ?? '', // Fournir une valeur vide si color est null
      weight: (json['weight'] != null) ? json['weight'].toDouble() : 0.0, // Vérifier si 'weight' n'est pas null
      distance: json['distance'] ?? '', // Fournir une valeur vide si distance est null
      imageUrl: json['imageUrl'] ?? '', // Fournir une valeur vide si imageUrl est null
      description: json['description'] ?? '', // Fournir une valeur vide si description est null
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : Owner.empty(), // Assurez-vous que Owner a une méthode "empty" si owner est null
    );
  }

  // Méthode toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'color': color,
      'weight': weight,
      'distance': distance,
      'imageUrl': imageUrl,
      'description': description,
      'owner': owner.toJson(), // Assurez-vous que Owner ait une méthode toJson
    };
  }
}
