import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readerbook/provider/auth_provider.dart';
import 'package:readerbook/provider/book_provider.dart';
import 'package:readerbook/pages/admin/buku_page.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Admin Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async {
              final confirmed = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Logout'),
                  content: Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                final success = await authProvider.logout();
                if (success) {
                  Navigator.of(context).pushReplacementNamed('/login');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authProvider.errorMessage)),
                  );
                }
              }
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
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Manage your books and users easily:',
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
                      icon: Icons.book,
                      title: 'Manage Books',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BukuPage()),
                        );
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.group,
                      title: 'Manage Users',
                      onTap: () {
                        // Tambahkan navigasi ke halaman Manage Users
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.analytics,
                      title: 'Analytics',
                      onTap: () {
                        // Tambahkan navigasi ke halaman Analytics
                      },
                    ),
                    _buildGridItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        // Tambahkan navigasi ke halaman Settings
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
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
