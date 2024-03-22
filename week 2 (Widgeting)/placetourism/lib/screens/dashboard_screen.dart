import 'package:flutter/material.dart';
import 'package:placetourism/models/tourism_place.dart';
import 'package:placetourism/screens/detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tempat Wisata'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final TourismPlace place = tourismPlaceList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(place: place);
                    }));
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
              itemCount: tourismPlaceList.length,
            ),
          ),
        );
      },
    );
  }
}
