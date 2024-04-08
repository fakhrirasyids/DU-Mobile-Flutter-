import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_place/provider/tourism_provider.dart';
import 'package:tourism_place/screens/login_screen.dart';

// Fungsi main() adalah titik awal eksekusi aplikasi Flutter
void main() {
  // Menjalankan aplikasi dengan memanggil fungsi runApp()
  // dan memberikan instance dari kelas MainApp sebagai argumen
  runApp(const MainApp());
}

// Kelas MainApp merupakan StatelessWidget yang tidak memiliki state internal
class MainApp extends StatelessWidget {
  // Konstruktor untuk kelas MainApp
  const MainApp({super.key});

  // Metode build() digunakan untuk membangun widget yang akan ditampilkan
  @override
  Widget build(BuildContext context) {
    // Mengembalikan instance dari MaterialApp
    // yang merupakan widget utama aplikasi Flutter dengan desain material
    return ChangeNotifierProvider(
      create: (context) => TourismProvider(),
      child: const MaterialApp(
          // Mengatur LoginScreen sebagai halaman awal (home) aplikasi
          home: LoginScreen()),
    );
  }
}
