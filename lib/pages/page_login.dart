import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page_dashboard.dart';

class PageLogin  extends StatelessWidget{
  const PageLogin({super.key});
  @override
  Widget build (BuildContext context) {

    final TextEditingController TxtUsername = TextEditingController();
    final TextEditingController TxtPassword = TextEditingController();

    // 2. Fungsi sederhana untuk hit API Login
    Future<void> prosesLogin() async {
      try {
        final response = await http.post(
          // Ganti dengan IP lokal/10.0.2.2 sesuai environment siswa
          Uri.parse('http://127.0.0.1:3000/login'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'email': TxtUsername.text,
            'password': TxtPassword.text,
          }),
        );

        // Cek apakah widget masih aktif sebelum menggunakan context
        if (!context.mounted) return;

        if (response.statusCode == 200) {
          // Jika login sukses, pindah ke dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PageDashboard()),
          );
        } else {
          // Jika gagal, tampilkan pesan sederhana
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Gagal! Username atau Password salah.')),
          );
        }
      } catch (e) {
        // Jika error koneksi (server mati / salah URL)
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(
                  Icons.verified_user,
                  size: 40,
                ),

                const Text('Login', style: TextStyle( fontSize: 30)),

                SizedBox(height: 40),

                TextField(
                  controller: TxtUsername,
                  decoration: InputDecoration(
                      labelText: 'Input Username'
                  ),
                ),

                TextField(
                  controller: TxtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Input Password'
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                    onPressed: () {
                      prosesLogin();
                    },
                    child: const Text('LOGIN')
                )

              ]
          ),
        )

      ),
    );
  }
}