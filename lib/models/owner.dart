class Owner {
  final String id;
  final String name;
  final String imageUrl;
  final String bio;

  Owner({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bio,
  });

  // Méthode pour créer un Owner "vide" ou par défaut
  factory Owner.empty() {
    return Owner(
      id: '', // id vide
      name: '', // nom vide
      imageUrl: '', // URL vide
      bio: '', // bio vide
    );
  }

  // Méthode pour transformer un objet JSON en un Owner
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] ?? '', // Si 'id' est null, utiliser une chaîne vide
      name: json['name'] ?? '', // Si 'name' est null, utiliser une chaîne vide
      imageUrl: json['imageUrl'] ?? '', // Si 'imageUrl' est null, utiliser une chaîne vide
      bio: json['bio'] ?? '', // Si 'bio' est null, utiliser une chaîne vide
    );
  }

  // Méthode pour transformer un Owner en un objet JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'bio': bio,
    };
  }
}
