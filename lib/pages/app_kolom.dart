import 'package:flutter/material.dart';

class AppKolom extends StatelessWidget{


  Widget build (BuildContext context) {

    return Scaffold(

      //INI APP BAR
      appBar: AppBar(
        title: const Text('Aplikasi Flutter'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.red,
      ),

      body: const Center(
        child: Column(
          children: [
            Text("Hallo ...",
            style: TextStyle(color: Colors.red),
            ),
            Text("Selamat Datang di Flutter"),
            Text("dan Selamat Berekplorasi")
          ],
        ),
      ),


    );

  }



}