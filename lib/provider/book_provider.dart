import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/books';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _books = responseData.map((data) => Book.fromJson(data)).toList();
      } else {
        _errorMessage = 'Failed to load books';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBook(Book book) async {
    _isLoading = true;
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/books';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(book.toJson()),
      );
      if (response.statusCode == 201) {
        _books.add(Book.fromJson(json.decode(response.body)));
      } else {
        _errorMessage = 'Failed to add book';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBook(Book book) async {
    _isLoading = true;
    notifyListeners();

    final url = 'http://127.0.0.1:8000/api/books/${book.id}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(book.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _books.indexWhere((b) => b.id == book.id);
        if (index != -1) {
          _books[index] = book;
        }
      } else {
        _errorMessage = 'Failed to update book';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    _isLoading = true;
    notifyListeners();

    final url = 'http://127.0.0.1:8000/api/books/$id';

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 204) {
        _books.removeWhere((book) => book.id == id);
      } else {
        _errorMessage = 'Failed to delete book';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
