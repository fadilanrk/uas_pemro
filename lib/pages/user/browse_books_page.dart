import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readerbook/provider/book_provider.dart';
import 'package:readerbook/models/book.dart';

class BrowseBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Browse Books',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          if (bookProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (bookProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(bookProvider.errorMessage));
          } else if (bookProvider.books.isEmpty) {
            return Center(child: Text('No books found'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookProvider.books.length,
              itemBuilder: (context, index) {
                Book book = bookProvider.books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  child: ListTile(
                    leading: Icon(Icons.book, color: Colors.brown),
                    title: Text(
                      book.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Author: ${book.author}\nYear: ${book.year}\nSinopsis: ${book.sinopsis}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
