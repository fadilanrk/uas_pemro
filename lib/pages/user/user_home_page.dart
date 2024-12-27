import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readerbook/pages/login.dart';
import 'package:readerbook/pages/user/browse_books_page.dart';
import 'package:readerbook/pages/user/favorites_page.dart';
import 'package:readerbook/pages/user/reading_history_page.dart';
import 'package:readerbook/pages/user/settings_page.dart';
import 'package:readerbook/provider/auth_provider.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'User Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<LoginProvider>(context, listen: false).logout().then((_) {
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Book Haven!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Discover your next great read:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown.shade700,
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildGridItem(
                      icon: Icons.menu_book,
                      title: 'Browse Books',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BrowseBooksPage()),
                        );
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.favorite,
                      title: 'Favorites',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavoritesPage()),
                        );
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.history,
                      title: 'Reading History',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReadingHistoryPage()),
                        );
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
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
    );
  }

  Widget _buildGridItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade100,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.brown,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown,
                fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserHomePage(),
        routes: {
          '/login': (context) => LoginPage(), // Ganti dengan halaman login Anda
        },
      ),
    ),
  );
}
