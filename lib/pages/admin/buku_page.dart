import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readerbook/models/book.dart';
import 'package:readerbook/provider/book_provider.dart';

class BukuPage extends StatefulWidget {
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _yearController = TextEditingController();
  final _sinopsisController = TextEditingController();
  bool _isEditing = false;
  Book? _selectedBook;

  @override
  void initState() {
    super.initState();
    Provider.of<BookProvider>(context, listen: false).fetchBooks();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isEditing && _selectedBook != null) {
        final updatedBook = Book(
          id: _selectedBook!.id,
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          sinopsis: _sinopsisController.text,
        );
        Provider.of<BookProvider>(context, listen: false)
            .updateBook(updatedBook)
            .then((_) {
          setState(() {
            _isEditing = false;
            _selectedBook = null;
            _titleController.clear();
            _authorController.clear();
            _yearController.clear();
            _sinopsisController.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Book updated successfully')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update book')),
          );
        });
      } else {
        final newBook = Book(
          id: 0,
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
          sinopsis: _sinopsisController.text,
        );
        Provider.of<BookProvider>(context, listen: false).addBook(newBook).then((_) {
          _titleController.clear();
          _authorController.clear();
          _yearController.clear();
          _sinopsisController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Book added successfully')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add book')),
          );
        });
      }
    }
  }

  void _editBook(Book book) {
    setState(() {
      _isEditing = true;
      _selectedBook = book;
      _titleController.text = book.title;
      _authorController.text = book.author;
      _yearController.text = book.year.toString();
      _sinopsisController.text = book.sinopsis;
    });
  }

  void _deleteBook(int id) {
    Provider.of<BookProvider>(context, listen: false).deleteBook(id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book deleted successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete book')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Manage Books',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(labelText: 'Author'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an author';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _yearController,
                    decoration: InputDecoration(labelText: 'Year'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a year';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid year';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _sinopsisController,
                    decoration: InputDecoration(labelText: 'Sinopsis'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a sinopsis';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(_isEditing ? 'Update Book' : 'Add Book'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<BookProvider>(
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _editBook(book);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteBook(book.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
