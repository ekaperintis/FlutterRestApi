import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_dashboard.dart';
import 'page_edit.dart';

class PageViewUser extends StatefulWidget{
  const PageViewUser({super.key});
  
  @override
  State<PageViewUser> createState() => _PageViewUserState();
  
}

class _PageViewUserState extends State<PageViewUser>{
  
  Future<List<dynamic>> getDataUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token");

    debugPrint(token as String?);
    
    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization' : 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> listUser = data['data']; //data("data");
      return listUser;
    } else{
      debugPrint("Gagal Memuat Data Users");
      throw Exception("Failed to read data users");
    }

  }

  // Fungsi DELETE Data
  Future<void> hapusUser(int idUser) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:3000/user/$idUser'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Refresh UI agar data yang terhapus hilang dari layar
        setState(() {});

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User berhasil dihapus')),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus user'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: FutureBuilder <List<dynamic>> (
        future: getDataUser(),
        builder: (context, snapshot) {

          // 1. TAMBAHKAN CEK INI: Jika data masih loading, tampilkan lingkaran putar
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. CEK JIKA ADA ERROR
          else if (snapshot.hasError) {
            debugPrint ('Terjadi Error: ${snapshot.error}');
            return Center(child: Text('Terjadi Error: ${snapshot.error}'));
          }

          // 3. CEK JIKA DATA KOSONG ATAU NULL
          else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Data kosong.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index){
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user['id'].toString()),
                  ),
                  title: Text(user['name'] ?? '-'),
                  subtitle: Text(user['email'] ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tombol Edit
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          // Pindah ke halaman edit dan tunggu hasilnya
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageEditUser(userData: user),
                            ),
                          );

                          // Jika kembali membawa nilai true, refresh halaman list-nya
                          if (result == true) {
                            setState(() {});
                          }
                        },
                      ),
                      // Tombol Hapus (yang sebelumnya sudah dibuat)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          hapusUser(user['id']);
                        },
                      ),
                    ],
                  ),
                );
              }
          );
        },
      ),
    );
  }
  
}