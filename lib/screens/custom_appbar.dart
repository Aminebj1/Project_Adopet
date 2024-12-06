import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Titre pour chaque page

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
  
      centerTitle: false,
      actions: [
        // Image circulaire pour le propriétaire
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              print('Profile clicked');
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/drawable-v24/owner.png'),
              radius: 20,
            ),
          ),
        ),
        // Icône de déconnexion
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            print('Logout clicked');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
