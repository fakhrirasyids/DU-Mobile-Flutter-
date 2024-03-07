import 'package:flutter/material.dart';

import 'screen/mobile_screen.dart';
import 'screen/web_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Wisata Bandung'),
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return const TourismPlaceList();
              } else if (constraints.maxWidth <= 1200) {
                return const TourismPlaceGrid(gridCount: 4);
              } else {
                return const TourismPlaceGrid(gridCount: 6);
              }
            },
          ),
        );
      },
    );
  }
}



