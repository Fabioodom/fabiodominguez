import 'package:flutter/material.dart';
import 'user_profile_screen.dart'; // Asegúrate de tener este archivo creado

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Profesional',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const UserProfileScreen(),
    );
  }
}
