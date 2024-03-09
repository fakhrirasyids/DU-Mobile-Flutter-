import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dico1/model/tourism_place.dart';

import '../screen/detail_mobile._screen.dart';
import '../screen/detail_web_screen.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(place: place);
        } else {
          return DetailMobilePage(place: place);
        }
      },
    );
  }
}
