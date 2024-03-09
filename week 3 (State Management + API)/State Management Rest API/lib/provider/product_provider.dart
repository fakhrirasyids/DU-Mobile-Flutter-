import 'dart:convert';

import 'package:dico1/model/tourism_place.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  String urlMaster =
      "https://doscom-university-m2h6f.ondigitalocean.app/api/v1/tourism-places";

  List<TourismPlace> _allData = [];
  List<TourismPlace> get allData => _allData;
  List _allComment = [];
  List get allComment => _allComment;

  Future<void> fetchData() async {
    _allData = [];
    try {
      final response = await http.get(Uri.parse(urlMaster));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];
        for (var item in responseData) {
          _allData.add(TourismPlace.fromJson(item));
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> addComment(int id, String name, String comment) async {
    Uri url = Uri.parse("$urlMaster/$id/comments?name=$name&comment=$comment");

    try {
      print("function addcoment $id");
      print("function addcomment $name");
      print("function addcomment $comment");
      final response = await http.post(
        url,
        // headers: {"Content-Type": "application/json"},
        body: json.encode(
          {"name": name, "comment": comment},
        ),
      );
      if (response.statusCode == 201) {
        print("Komentar berhasil ditambahkan: ${response.body}");
      } else {
        print(
            "Gagal menambahkan komentar. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> getComment(int id) async {
    Uri url = Uri.parse("$urlMaster/$id/comments");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];
        _allComment = responseData;
        print(responseData);
        notifyListeners();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  void toggleFavorite(int id) {
    final index = _allData.indexWhere((place) => place.id == id);
    if (index != -1) {
      _allData[index].isFavorite = !_allData[index].isFavorite;
      notifyListeners();
    }
  }
}
