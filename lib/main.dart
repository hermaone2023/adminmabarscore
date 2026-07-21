import 'package:flutter/material.dart';
import 'main_wrapper.dart';

void main() {
  runApp(const MabarScoreAdminApp());
}

class MabarScoreAdminApp extends StatelessWidget {
  const MabarScoreAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MabarScore Admin Dashboard',
      theme: ThemeData(
        primaryColor: const Color(0xFF031B19), // Warna branding kita
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainWrapper(), // Memanggil MainWrapper
    );
  }
}
