import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/dog.dart';
import '../../models/owner.dart';


class ApiService {
  final String baseUrl = 'http://192.168.100.197:5000/api';

  Future<List<Owner>> getOwners() async {
    final response = await http.get(Uri.parse('$baseUrl/owners'));
    
    if (response.statusCode == 200) {
      List<dynamic> ownersJson = json.decode(response.body);
      return ownersJson.map((json) => Owner.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load owners');
    }
  }
  Future<List<Dog>> fetchDogs() async {
    final response = await http.get(Uri.parse('$baseUrl/dogs'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dog) => Dog.fromJson(dog)).toList();
    } else {
      throw Exception('Failed to load dogs');
    }
  }

  Future<void> addDog(Dog dog) async {
    final response = await http.post(
      Uri.parse('$baseUrl/dogs'), // Assurez-vous que l'URL est correcte
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dog.toJson()), // Vérifiez que la méthode `toJson` est définie pour Dog
    );

    if (response.statusCode != 201) {
      // Afficher l'erreur en cas d'échec
      throw Exception('Failed to add dog: ${response.body}');
    }
  }
  Future<void> updateDog(Dog dog) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dogs/${dog.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dog.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update dog');
    }
  }
bool isValidObjectId(String id) {
  // Check if the ID is a valid ObjectId (24-character hexadecimal string)
  final objectIdPattern = RegExp(r'^[a-fA-F0-9]{24}$');
  return objectIdPattern.hasMatch(id);
}

Future<void> deleteDog(String dogId) async {
  // First, check if the ID is valid
  if (!isValidObjectId(dogId)) {
    throw Exception('Invalid Dog ID format');
  }


  try {
    final response = await http.delete(
      Uri.parse('$baseUrl/dogs/$dogId'),  // Ensure the full URL is correct
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete dog: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to delete dog: $e');
  }
}


}