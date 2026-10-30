import 'package:flutter/material.dart';

class PageInput extends StatelessWidget{
  const PageInput({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("Input Data User"

              ),

              const SizedBox(height: 10,),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Masukkan Name"
                ),
              ),

              const SizedBox(height: 20,),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Masukkan Email"
                ),
              ),

              const SizedBox(height: 10,),

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Masukkan Password"
                ),
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  ElevatedButton(onPressed:  () {} , child: const Text("Simpan")),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed:  () {} , child: const Text("Batal")),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}