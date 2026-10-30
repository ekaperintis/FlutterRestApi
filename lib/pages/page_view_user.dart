import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_dashboard.dart';

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
                );
              }
          );
        },
      ),
    );
  }
  
}