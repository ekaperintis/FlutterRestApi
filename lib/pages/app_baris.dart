import 'package:flutter/material.dart';

class AppBaris extends StatelessWidget {
  VoidCallback? get onPressed => null;




  Widget build (BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikas Flutter'),
      ),

      body: Center(
        child: Row(
          children: [
            Text('Hallo\n\n\n'),
            Text('Selamat Datang\n\n\n'),
            Text('di Aplikasi Flutter\n\n\n'),

            ElevatedButton(onPressed: () {

            },
                child: Text('Simpan')
            ),
            ElevatedButton(onPressed: () {
              print ("DI TEKAN");
            } , child:Text('Batal'))
          ],
        ),
      ),
    );

  }
}