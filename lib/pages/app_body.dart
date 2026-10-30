import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Flutter'),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
      ),

      body: const Center(
        child: Text(
          'Hallo Selamat Datang di Aplikasi Mobile',
          style: TextStyle(color: Colors.deepPurple, fontSize: 30,
          fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }
}
