import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup() async {
    try {
      // Création du compte avec Firebase
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Redirection vers la page de connexion après succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Affiche un message d'erreur en cas d'échec
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc pour l'ensemble de la page
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding autour de toute la page
          child: Center( // Centre tout le contenu de la page
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Section logo et texte
                Image.asset(
                  'lib/assets/drawable/wiggle_logo.png', // Assurez-vous que l'image est dans le dossier assets
                  height: 150,
                ),
                SizedBox(height: 20), // Espacement entre l'image et le texte
                Text(
                  "Welcome to Pet Adoption",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Texte noir
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Signup to find your furry friend!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey, // Texte gris
                  ),
                ),
                SizedBox(height: 30),
                // Formulaire d'inscription
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding pour les champs de texte
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.blueAccent), // Icône bleue
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding pour le champ de mot de passe
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.blueAccent), // Icône bleue
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Couleur bleue pour le bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Texte du bouton en blanc
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Retour à la page de connexion
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Already have an account? Login here",
                    style: TextStyle(color: Colors.blueAccent), // Texte bleu
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
