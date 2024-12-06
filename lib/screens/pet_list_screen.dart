import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../service/api_service.dart'; // Assurez-vous que l'import est correct
import 'pet_detail_screen.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  late Future<List<Dog>> futureDogs;

  @override
  void initState() {
    super.initState();
    futureDogs = ApiService().fetchDogs(); // Récupérer les chiens au démarrage de l'écran
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Dogs'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Dog>>(
        future: futureDogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load dogs: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No dogs available.'));
          } else {
            final dogs = snapshot.data!;
            return ListView.builder(
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                final dog = dogs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(dog.imageUrl), // Affichage de l'image depuis l'URL
                    ),
                    title: Text(
                      dog.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('${dog.age} years old | ${dog.gender}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetDetailScreen(dog: dog),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
