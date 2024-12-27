import 'package:flutter/material.dart';

class ReadingHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Reading History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Reading History Page',
          style: TextStyle(fontSize: 24, color: Colors.brown),
        ),
      ),
    );
  }
}
