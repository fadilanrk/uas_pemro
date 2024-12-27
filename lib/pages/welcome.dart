import 'package:flutter/material.dart';
import 'package:readerbook/pages/login.dart';
import 'package:readerbook/pages/register.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Welcome Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    'https://png.pngtree.com/png-clipart/20190516/original/pngtree-children-reading-book-png-image_3634303.jpg', // Ganti dengan URL gambar Anda
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Image not found',
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Welcome to Read Book App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Discover a world of books:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      _buildButton(
                        title: 'Login',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        title: 'Register',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String title, required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}
