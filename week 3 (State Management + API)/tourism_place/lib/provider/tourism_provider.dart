import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/tourism_place.dart';

class TourismProvider with ChangeNotifier {
  String urlMaster =
      "https://doscom-university-m2h6f.ondigitalocean.app/api/v1/tourism-places";
  List<TourismPlace> _tourismPlaceList = [];
  List<TourismPlace> get tourismPlaceList => _tourismPlaceList;
  List _allComment = [];
  List get allComment => _allComment;

  Future<void> fetchData() async {
    _tourismPlaceList = [];
    try {
      final response = await http.get(Uri.parse(urlMaster));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];
        print(responseData);
        for (var data in responseData) {
          _tourismPlaceList.add(TourismPlace.fromJson(data));
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getComments(int id) async {
    Uri url = Uri.parse('$urlMaster/$id/comments');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];
        print(responseData);
        _allComment = responseData;
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addComment(int id, String name, String comment) async {
    Uri url = Uri.parse('$urlMaster/$id/comments');
    try {
      final response = await http.post(
        url,
        body: json.decode('{"name": "$name", "comment": "$comment"}'),
      );
      if (response.statusCode == 201) {
        print("Success add comment");
      } else {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      print(e);
    }
  }

  void toggleFavorite(int id) {
    final index = _tourismPlaceList.indexWhere((place) => place.id == id);
    if (index != -1) {
      _tourismPlaceList[index].isFavorite =
          !_tourismPlaceList[index].isFavorite;
      notifyListeners();
    }
  }
}
