import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog.dart';

class EditDogScreen extends StatefulWidget {
  final Dog dog;

  const EditDogScreen({Key? key, required this.dog}) : super(key: key);

  @override
  _EditDogScreenState createState() => _EditDogScreenState();
}

class _EditDogScreenState extends State<EditDogScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late double _age;
  late String _gender;
  late String _color;
  late double _weight;
  late String _distance;
  late String _imageUrl;
  late String _description;

  late Dog _updatedDog;  // Add this line to store the updated dog locally

  @override
  void initState() {
    super.initState();
    // Initialiser les champs avec les valeurs actuelles du chien
    _name = widget.dog.name;
    _age = widget.dog.age;
    _gender = widget.dog.gender;
    _color = widget.dog.color;
    _weight = widget.dog.weight;
    _distance = widget.dog.distance;
    _imageUrl = widget.dog.imageUrl;
    _description = widget.dog.description;
    _updatedDog = widget.dog;  // Initialize the local dog state
  }
Future<void> updateDog(Dog dog) async {
  final url = 'http://192.168.100.197:5000/api/dogs/${dog.id}';

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dog.toJson()),
    );

    if (response.statusCode == 200) {
      print('Dog updated successfully');
      Dog updatedDog = Dog.fromJson(json.decode(response.body));

      // Utiliser setState pour mettre à jour l'UI
      setState(() {
        _updatedDog = updatedDog;
      });

      // Vous pouvez aussi utiliser un FutureBuilder dans la page principale
      Navigator.pop(context, updatedDog); // Retour à la page précédente
    } else {
      print('Failed to update dog. Status code: ${response.statusCode}');
      throw Exception('Failed to update dog');
    }
  } catch (error) {
    print('Error updating dog: $error');
    throw Exception('Failed to update dog');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Dog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _age.toString(),
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _age = double.tryParse(value) ?? 0.0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _color,
                decoration: const InputDecoration(labelText: 'Color'),
                onChanged: (value) {
                  setState(() {
                    _color = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _weight.toString(),
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _weight = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              TextFormField(
                initialValue: _distance,
                decoration: const InputDecoration(labelText: 'Distance'),
                onChanged: (value) {
                  setState(() {
                    _distance = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onChanged: (value) {
                  setState(() {
                    _imageUrl = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Update the dog with the new values
                    updateDog(Dog(
                      id: widget.dog.id,
                      name: _name,
                      age: _age,
                      gender: _gender,
                      color: _color,
                      weight: _weight,
                      distance: _distance,
                      imageUrl: _imageUrl,
                      description: _description,
                      owner: widget.dog.owner,
                    ));
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
