import 'package:aplikasi_guru/pages/page_input.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_guru/pages/app_bar.dart';
import 'package:aplikasi_guru/pages/app_body.dart';
import 'pages/app_kolom.dart';
import 'pages/app_baris.dart';
import 'pages/page_dashboard.dart';
import 'pages/page_login.dart';
import 'pages/page_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageLogin(),
    );
  }
}


