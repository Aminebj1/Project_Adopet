import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../service/api_service.dart';
import '../models/owner.dart';
import 'package:image_picker/image_picker.dart'; // Importer le package image_picker
import 'dart:io'; // Importer pour utiliser File

class AddDogScreen extends StatefulWidget {
  final VoidCallback onDogAdded;

  AddDogScreen({required this.onDogAdded});

  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender = 'Male'; // Variable pour stocker le genre sélectionné
  final _imageUrlController = TextEditingController();
  File? _selectedImage; // Pour stocker l'image sélectionnée
  final _colorController = TextEditingController(); // Contrôleur pour la couleur
  final _weightController = TextEditingController(); // Contrôleur pour le poids
  final _distanceController = TextEditingController(); // Contrôleur pour la distance
  final _descriptionController = TextEditingController(); // Contrôleur pour la description

  final ImagePicker _picker = ImagePicker(); // Instance pour image_picker

  String? _selectedOwnerId; // ID du propriétaire sélectionné
  List<Owner> _owners = []; // Liste des propriétaires
  bool _isLoading = true; // Indicateur de chargement pour savoir quand afficher la liste des propriétaires

  // Méthode pour choisir l'image depuis la galerie
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Mettre à jour l'image sélectionnée
        _imageUrlController.text = pickedFile.path; // Mettre à jour l'URL de l'image dans le champ de texte
      });
    }
  }

  // Méthode pour charger la liste des propriétaires depuis l'API
  Future<void> _loadOwners() async {
    try {
      final owners = await ApiService().getOwners(); // Supposons que ApiService() ait une méthode getOwners()
      setState(() {
        _owners = owners;
        _isLoading = false; // Une fois les propriétaires chargés, on arrête le chargement
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load owners: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadOwners(); // Charger les propriétaires quand l'écran est initialisé
  }

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    final newDog = Dog(
      name: _nameController.text,
      age: double.tryParse(_ageController.text) ?? 0.0,
      gender: _selectedGender ?? '',
      imageUrl: _imageUrlController.text,
      color: _colorController.text,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      distance: _distanceController.text,
      description: _descriptionController.text,
      owner: _selectedOwnerId != null && _selectedOwnerId!.isNotEmpty
          ? _owners.firstWhere((owner) => owner.id == _selectedOwnerId)
          : Owner.empty(), // Si aucun propriétaire n'est sélectionné, on utilise un Owner vide
    );

    try {
      await ApiService().addDog(newDog);
      widget.onDogAdded();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add dog: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Dog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              // Dropdown pour le genre
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female']
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              // Sélecteur d'image
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an image';
                  }
                  return null;
                },
                readOnly: true, // Le champ est en lecture seule, car l'image est choisie avec le picker
              ),
              ElevatedButton(
                onPressed: _pickImage, // Appel de la méthode pour choisir l'image
                child: const Text('Pick an Image'),
              ),
              // Liste des propriétaires
              _isLoading
                  ? const CircularProgressIndicator() // Afficher un indicateur de chargement si les propriétaires sont en cours de récupération
                  : DropdownButtonFormField<String>(
                      value: _selectedOwnerId,
                      decoration: const InputDecoration(labelText: 'Select Owner'),
                      items: _owners.map((owner) {
                        return DropdownMenuItem<String>(
                          value: owner.id, // Vous utilisez ici l'ID du propriétaire comme valeur
                          child: Text(owner.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedOwnerId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an owner';
                        }
                        return null;
                      },
                    ),
              // Champs supplémentaires
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a color';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(labelText: 'Distance'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a distance';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Dog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
