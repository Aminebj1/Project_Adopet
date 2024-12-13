import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../service/api_service.dart'; // Assurez-vous que l'import est correct
import 'pet_detail_screen.dart';
import 'AddDogScreen.dart';

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
                      backgroundImage: NetworkImage(dog.imageUrl),
                    ),
                    title: Text(
                      dog.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('${dog.age} years old | ${dog.gender}'),
          trailing: IconButton(
  icon: Icon(Icons.delete, color: Colors.red),
  onPressed: () {
    final dogId = dog.id.toString(); // Convertissez en String si nécessaire
    print('Deleting dog with ID: $dogId'); // Ajoutez un print pour vérifier l'ID
    _confirmDelete(context, dogId);
  },
),



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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDogScreen(onDogAdded: _refreshDogs),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Méthode pour confirmer et supprimer un chien
  // Method to confirm and delete a dog
void _confirmDelete(BuildContext context, String dogId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Dog'),
        content: Text('Are you sure you want to delete this dog?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog without deleting
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteDog(dogId); // Delete the dog
              Navigator.pop(context); // Close the dialog after deletion
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}

  // Méthode pour supprimer un chien
  Future<void> _deleteDog(String dogId) async {
    try {
      await ApiService().deleteDog(dogId); // Appelez votre API pour supprimer le chien
      _refreshDogs(); // Rafraîchir la liste des chiens après suppression
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete dog: $e')),
      );
    }
  }

  // Méthode pour rafraîchir la liste des chiens après ajout
  void _refreshDogs() {
    setState(() {
      futureDogs = ApiService().fetchDogs();
    });
  }
}
