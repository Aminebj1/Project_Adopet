import 'package:flutter/material.dart';
import 'screens/pet_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
     ),
      debugShowCheckedModeBanner: false,
      home: PetListScreen(),  // The pet listing screen
    );
  }
}


