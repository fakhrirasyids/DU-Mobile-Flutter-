import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../fonts/fontstyle.dart';
import '../model/tourism_place.dart';
import '../provider/product_provider.dart';

class DetailMobilePage extends StatefulWidget {
  final TourismPlace place;

  const DetailMobilePage({Key? key, required this.place}) : super(key: key);

  @override
  State<DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<DetailMobilePage> {
  bool isInit = true;
  bool isLoading = false;

  List _comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  void fetchComments() async {
    try {
      await Provider.of<ProductProvider>(context, listen: false)
          .getComment(widget.place.id);
      setState(() {
        _comments =
            Provider.of<ProductProvider>(context, listen: false).allComment;
      });
    } catch (error) {
      debugPrint("Error fetching comments: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    void showCommentModal(BuildContext context, int id) {
      final TextEditingController usernameController = TextEditingController();
      final TextEditingController commentController = TextEditingController();
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Masukan Nama',
                          hintStyle: informationTextStyle),
                      autofocus: true,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Berikan Komentar',
                          hintStyle: informationTextStyle),
                      autofocus: true,
                      controller: commentController,
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          Provider.of<ProductProvider>(context, listen: false)
                              .addComment(id, usernameController.text,
                                  commentController.text);
                          Navigator.pop(context);
                          fetchComments();
                        },
                        child: Text(
                          "Send",
                          style: detailTextStyle(
                              Colors.white, FontWeight.bold, 15.0),
                        ),
                      ),
                    )
                  ],
                ),
              ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(widget.place.imageAsset),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Consumer<ProductProvider>(
                          builder: (context, productData, child) => IconButton(
                            icon: Icon(
                              widget.place.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              productData.toggleFavorite(widget.place.id);
                            },
                          ),
                        ),
                        // const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.place.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.place.openDays,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.access_time),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.place.openTime,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.place.ticketPrice,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.place.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Komentar",
                          style: detailTextStyle(
                              Colors.black, FontWeight.bold, 20),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () {
                            print(widget.place.id);
                            showCommentModal(context, widget.place.id);
                          },
                          child: Text(
                            "Komen",
                            style: detailTextStyle(
                                Colors.white, FontWeight.w700, 15.0),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    (isLoading)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 400,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _comments.map(
                                  (comment) {
                                    DateTime createdAt =
                                        DateTime.parse(comment['created_at']);
                                    String formattedCreatedAt =
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .format(createdAt);

                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.primaries[
                                                Random().nextInt(
                                                    Colors.primaries.length)],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                comment['name'],
                                                style: informationTextStyle,
                                              ),
                                              Text(
                                                '${formattedCreatedAt}',
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(comment['comment']),
                                        ),
                                        Divider()
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
