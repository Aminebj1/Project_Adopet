class Owner {
  final String name;
  final String bio;
  final String imageUrl;

  Owner({
    required this.name,
    required this.bio,
    required this.imageUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'] ?? '', // Si 'name' est null, on retourne une chaîne vide
      bio: json['bio'] ?? '',   // Si 'bio' est null, on retourne une chaîne vide
      imageUrl: json['imageUrl'] ?? '', // Si 'imageUrl' est null, on retourne une chaîne vide
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }

  // Méthode empty pour créer un Owner vide
  static Owner empty() {
    return Owner(
      name: '',        // Valeur par défaut vide
      bio: '',         // Valeur par défaut vide
      imageUrl: '',    // Valeur par défaut vide
    );
  }
}
