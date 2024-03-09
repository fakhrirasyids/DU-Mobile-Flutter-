import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/tourism_place.dart';
import '../pages/detail_screen.dart';
import '../provider/product_provider.dart';

class TourismPlaceGrid extends StatelessWidget {
  final int gridCount;

  const TourismPlaceGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webData = Provider.of<ProductProvider>(context);
    print("DATA PADA WEB INI $webData");
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemCount: webData.allData.length,
        itemBuilder: (context, index) {
          TourismPlace place = webData.allData[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(place: place)),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      place.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      place.location,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
