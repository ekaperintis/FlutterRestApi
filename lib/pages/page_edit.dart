import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PageEditUser extends StatefulWidget {
  // Menerima data user yang dikirim dari halaman list sebelumnya
  final Map<String, dynamic> userData;

  const PageEditUser({super.key, required this.userData});

  @override
  State<PageEditUser> createState() => _PageEditUserState();
}

class _PageEditUserState extends State<PageEditUser> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Mengisi TextField secara otomatis dengan data lama
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
  }

  // Fungsi untuk mengirim request PUT ke Next.js API
  Future<void> updateDataUser() async {
    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";
    final int idUser = widget.userData['id'];

    try {
      // Endpoint PUT sesuai ID (contoh: http://127.0.0.1:3000/user/14)
      final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/user/$idUser'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          // Jika di API Anda butuh password saat edit, tambahkan field password di sini
        }),
      );

      setState(() => _isLoading = false);

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil memperbarui data!'), backgroundColor: Colors.green),
        );
        // Kembali ke halaman sebelumnya dan membawa tanda true (untuk refresh data)
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui data'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : updateDataUser,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('UPDATE DATA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}