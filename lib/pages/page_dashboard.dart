import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page_input.dart';
import 'page_view_user.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({super.key});

  @override
  Widget build (BuildContext context){

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text('Dashboard', style: TextStyle(fontSize: 50),),
              const SizedBox(height: 40,),
              Wrap(alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PageViewUser()));
                }, child: const Text('lihat Data')),

                SizedBox (width: 10,),

                //Tombol Input Data
                ElevatedButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PageInput()));
                }, child: const Text('Input Data')),

                SizedBox(width: 10,),

                ElevatedButton(onPressed: () {}, child: const Text('Edit Data')),

                SizedBox (width: 10,),

                ElevatedButton(onPressed: () {}, child: const Text('Hapus Data')),

                SizedBox (width: 10,),

                ElevatedButton(onPressed: () {SystemNavigator.pop();}, child: const Text('Keluar Aplikasi')),
              ],
              )
            ],
          ),
        ),
      ),
    );
  }

}