import 'package:dico1/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:dico1/pages/main_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wisata Bandung',
        theme: ThemeData(),
        home: MainScreen(),
      ),
    );
  }
}
