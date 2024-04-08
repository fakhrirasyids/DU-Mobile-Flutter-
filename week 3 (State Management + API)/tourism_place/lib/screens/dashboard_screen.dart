import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourism_place/screens/detail_screen.dart';

import '../provider/tourism_provider.dart';

// Kelas DashboardScreen merupakan StatelessWidget yang menampilkan daftar tempat wisata
class DashboardScreen extends StatefulWidget {
  // Konstruktor untuk kelas DashboardScreen
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Metode build() untuk membangun widget yang akan ditampilkan
  late Future<void> _futureData;
  @override
  void initState() {
    super.initState();
    _futureData =
        Provider.of<TourismProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final allData = Provider.of<TourismProvider>(context);
    return Scaffold(
      // AppBar dengan judul "Places"
      appBar: AppBar(
        title: Text('Places'),
      ),
      // Body Scaffold berisi ListView.builder untuk menampilkan daftar tempat wisata
      body: FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final place = allData.tourismPlaceList[index];
              // Mendapatkan data tempat wisata dari daftar tourismPlaceList
              return InkWell(
                // Ketika item diklik, navigasi ke DetailScreen dengan data tempat wisata yang dipilih
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailScreen(place: place);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [
                      // Gambar tempat wisata
                      Expanded(
                        flex: 1,
                        child: Image.asset(place.imageAsset),
                      ),
                      // Nama dan lokasi tempat wisata
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8),
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
                      ),
                    ],
                  ),
                ),
              );
            },
            // Jumlah item yang akan dibangun sesuai dengan panjang daftar tourismPlaceList
            itemCount: allData.tourismPlaceList.length,
          );
        },
      ),
    );
  }
}
