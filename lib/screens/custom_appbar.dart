import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Titre pour chaque page

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent, // Couleur de fond personnalisée
      elevation: 4.0, // Légère ombre sous l'AppBar
      title: Text(
        title, 
        style: TextStyle(
          fontSize: 20.0, 
          fontWeight: FontWeight.bold,
          color: Colors.white, // Couleur du texte
        ),
      ),
      centerTitle: true, // Centrer le titre
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              print('Profile clicked');
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/drawable-v24/owner.png'),
              radius: 22.0,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            print('Logout clicked');
          },
          color: Colors.white, // Icône blanche pour une meilleure lisibilité
        ),
        const SizedBox(width: 10), // Ajouter un peu d'espace entre les éléments
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Taille de l'AppBar
}
