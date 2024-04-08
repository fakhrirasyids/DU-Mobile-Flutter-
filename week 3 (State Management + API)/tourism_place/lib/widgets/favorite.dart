import 'package:flutter/material.dart';

// Kelas FavoriteButton merupakan StatefulWidget yang menampilkan tombol favorit
class FavoriteButton extends StatefulWidget {
 // Konstruktor untuk kelas FavoriteButton
 const FavoriteButton({super.key});

 // Membuat state untuk kelas FavoriteButton
 @override
 State<FavoriteButton> createState() => _FavoriteButtonState();
}

// Kelas _FavoriteButtonState merupakan state untuk kelas FavoriteButton
class _FavoriteButtonState extends State<FavoriteButton> {
 // Variabel boolean untuk menyimpan status favorit
 bool isFavorite = false;

 // Metode build() untuk membangun widget yang akan ditampilkan
 @override
 Widget build(BuildContext context) {
   return IconButton(
     // Ikon yang akan ditampilkan (favorit atau bukan)
     icon: Icon(
       isFavorite ? Icons.favorite : Icons.favorite_border,
       color: Colors.red,
     ),
     // Ketika tombol ditekan, status favorit akan diubah
     onPressed: () {
       setState(() {
         isFavorite = !isFavorite;
       });
     }
   );
 }
}