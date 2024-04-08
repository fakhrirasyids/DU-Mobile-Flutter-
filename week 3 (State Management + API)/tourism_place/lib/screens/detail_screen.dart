import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourism_place/models/tourism_place.dart';
import 'package:tourism_place/provider/tourism_provider.dart';
import 'package:tourism_place/widgets/favorite.dart';

// Membuat variabel informationTextStyle dengan gaya teks tertentu
var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

// Kelas DetailScreen merupakan StatelessWidget yang menampilkan detail tempat wisata
class DetailScreen extends StatefulWidget {
  // Konstruktor untuk kelas DetailScreen yang menerima parameter place
  const DetailScreen({Key? key, required this.place}) : super(key: key);

  // Variabel final place yang menyimpan data TourismPlace
  final TourismPlace place;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Metode build() untuk membangun widget yang akan ditampilkan
  List _comments = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  void fetchComments() async {
    try {
      await Provider.of<TourismProvider>(context, listen: false)
          .getComments(widget.place.id);
      setState(() {
        _comments =
            Provider.of<TourismProvider>(context, listen: false).allComment;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    void showCommentModal(BuildContext context, int id) {
      final TextEditingController _usernameController = TextEditingController();
      final TextEditingController _commentController = TextEditingController();

      showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<TourismProvider>(context, listen: false)
                      .addComment(id, _usernameController.text,
                          _commentController.text);
                  Navigator.pop(context);
                  fetchComments();
                },
                child: Text("Kirim"),
              ),
            ],
          ),
        ),
      );
    }

    final allComment = Provider.of<TourismProvider>(context, listen: false);
    return Scaffold(
      // Body Scaffold berisi SingleChildScrollView untuk memungkinkan scroll vertikal
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Stack yang berisi gambar tempat wisata dan tombol navigasi kembali
            Stack(
              children: <Widget>[
                Image.asset(widget.place.imageAsset),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //  FavoriteButton(),
                        Consumer<TourismProvider>(
                          builder: (context, placeData, child) {
                            return IconButton(
                              onPressed: () {
                                placeData.toggleFavorite(widget.place.id);
                              },
                              icon: Icon(widget.place.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              color: Colors.red,
                            );
                          },
                        ) // Widget FavoriteButton dari file favorite.dart
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Container yang menampilkan informasi hari buka, jam buka, dan harga tiket
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Kolom untuk hari buka
                  Column(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      const SizedBox(height: 8),
                      Text(
                        widget.place.openDays,
                        style: informationTextStyle,
                      )
                    ],
                  ),
                  // Kolom untuk jam buka
                  Column(
                    children: <Widget>[
                      const Icon(Icons.access_time),
                      const SizedBox(height: 8),
                      Text(
                        widget.place.openTime,
                        style: informationTextStyle,
                      )
                    ],
                  ),
                  // Kolom untuk harga tiket
                  Column(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(height: 8),
                      Text(
                        widget.place.ticketPrice,
                        style: informationTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Container yang menampilkan deskripsi tempat wisata
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                widget.place.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            // SizedBox yang menampilkan galeri gambar tempat wisata dalam ListView horizontal
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Komentar "),
                        ElevatedButton(
                          onPressed: () {
                            // allComment.getComments(widget.place.id);
                            showCommentModal(context, widget.place.id);
                          },
                          child: Text(
                            "Komen",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                        )
                      ],
                    ),
                    const Divider(),
                    (isLoading)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 400,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _comments.map((e) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(e['name']),
                                      subtitle: Text(e['comment']),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
