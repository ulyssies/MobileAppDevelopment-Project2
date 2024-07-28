import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential;

      if (_loginController.text.contains('@')) {
        // Login with email
        userCredential = await _auth.signInWithEmailAndPassword(
          email: _loginController.text,
          password: _passwordController.text,
        );
      } else {
        // Login with username
        QuerySnapshot userQuery = await _firestore
            .collection('users')
            .where('username', isEqualTo: _loginController.text)
            .get();
        if (userQuery.docs.isNotEmpty) {
          var userData = userQuery.docs[0];
          userCredential = await _auth.signInWithEmailAndPassword(
            email: userData['email'],
            password: _passwordController.text,
          );
        } else {
          throw FirebaseAuthException(
              code: 'user-not-found',
              message: 'No user found with that username');
        }
      }

      String username = _loginController.text.contains('@')
          ? (await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get())['username']
          : _loginController.text;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 200),
        toolbarHeight: 300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController, // Login field for email or username
              decoration: const InputDecoration(labelText: 'Email or Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 43, 43, 43)),
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 43, 43, 43)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
