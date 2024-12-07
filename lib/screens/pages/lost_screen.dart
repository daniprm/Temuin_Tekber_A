import 'package:flutter/material.dart';
import 'package:temuin/screens/pages/found_detail.dart';

class LostPage extends StatelessWidget {
  const LostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Lost Stuffs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          LostAndFoundItem(
            date: "17 Nov 2024",
            items: [
              LostItem("TWS", "Ruang 4101", "assets/tws.jpg", "Electronics"),
              LostItem("Tumbler", "Ruang 4201", "assets/tumbler.jpg",
                  "Peralatan Makan/Minum"),
              LostItem("Charger", "Sekitar Gedung 3", "assets/charger.jpg",
                  "Electronics"),
            ],
          ),
          LostAndFoundItem(
            date: "18 Nov 2024",
            items: [
              LostItem("TWS", "Ruang 1101", "assets/tws.jpg", "Electronics"),
              LostItem("Tumbler", "Sekitar Gedung 2", "assets/tumbler.jpg",
                  "Peralatan Makan/Minum"),
              LostItem("Charger", "Studio Pemrograman", "assets/charger.jpg",
                  "Electronics"),
            ],
          ),
        ],
      ),
    );
  }
}

class LostAndFoundItem extends StatelessWidget {
  final String date;
  final List<LostItem> items;

  const LostAndFoundItem({super.key, required this.date, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(date,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Divider(thickness: 2, color: Colors.grey),
        ...items.map((item) => Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.location,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoundDetailScreen(
                                name: item.name,
                                category: item.category,
                                location: item.location,
                                date: date,
                                image: item.imagePath,
                              )),
                    );
                  },
                ),
                Divider(thickness: 1, color: Colors.grey[600]),
              ],
            )),
      ],
    );
  }
}

class LostItem {
  final String name;
  final String location;
  final String imagePath;
  final String category;

  LostItem(this.name, this.location, this.imagePath, this.category);
}
