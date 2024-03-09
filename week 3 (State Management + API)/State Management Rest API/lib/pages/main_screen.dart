import 'package:dico1/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/mobile_screen.dart';
import '../screen/web_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<void> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData =
        Provider.of<ProductProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // _futureData = Provider.of<ProductData>(context, listen: false).fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Bandung'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.hasError);
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth <= 600) {
                  return const TourismPlaceList();
                } else if (constraints.maxWidth <= 1200) {
                  return const TourismPlaceGrid(gridCount: 4);
                } else {
                  return const TourismPlaceGrid(gridCount: 6);
                }
              },
            );
          }
        },
      ),
    );
  }
}
