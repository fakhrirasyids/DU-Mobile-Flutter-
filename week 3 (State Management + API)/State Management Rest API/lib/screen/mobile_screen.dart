import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/tourism_place.dart';
import '../pages/detail_screen.dart';
import '../provider/product_provider.dart';

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allData = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = allData.allData[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(place: place)),
              );
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(place.imageAsset),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            place.name,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(place.location),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: allData.allData.length,
      ),
    );
  }
}
