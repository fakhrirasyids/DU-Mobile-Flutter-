import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tourism_place/screens/dashboard_screen.dart';

import '../provider/tourism_provider.dart';

// Kelas LoginScreen merupakan StatefulWidget yang memiliki state internal
class LoginScreen extends StatefulWidget {
  // Konstruktor konstan untuk kelas LoginScreen
  const LoginScreen({super.key});

  // Metode createState() untuk membuat instance dari state kelas LoginScreen
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Kelas _LoginScreenState merupakan state untuk kelas LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // Metode build() untuk membangun widget yang akan ditampilkan
  @override
  Widget build(BuildContext context) {
    final allData = Provider.of<TourismProvider>(context, listen: false);
    return Scaffold(
      // Mengonfigurasi AppBar dengan judul "Login" dan posisi judul di tengah
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      // Mengonfigurasi body Scaffold dengan sebuah kolom di tengah
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sebuah Card dengan elevasi 8 dan bentuk RoundedRectangleBorder
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Sebuah TextFormField untuk input email dengan dekorasi tertentu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Sebuah TextFormField untuk input password dengan dekorasi tertentu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    // Sebuah ElevatedButton dengan teks "Login"
                    ElevatedButton(
                      onPressed: () {
                        // Ketika tombol ditekan, navigasi akan diarahkan ke DashboardScreen
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
