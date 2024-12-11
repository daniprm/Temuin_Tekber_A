import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Temuin/screens/pages/lost/lost_detail.dart';
import 'package:Temuin/services/database.dart';

class LostPage extends StatelessWidget {
  const LostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Lost Items',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getLostsCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error fetching data',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No lost items found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // Kelompokkan data berdasarkan tanggal
          final groupedItems = <String, List<Map<String, dynamic>>>{};
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final DateTime date = data['date'].toDate(); // Konversi ke DateTime
            final formattedDate =
                "${date.day} ${_monthName(date.month)} ${date.year}";

            if (!groupedItems.containsKey(formattedDate)) {
              groupedItems[formattedDate] = [];
            }
            groupedItems[formattedDate]!.add({
              ...data,
              'itemId': doc.id,
            });
          }

          // Buat daftar widget
          final dateSections = groupedItems.entries.map((entry) {
            final date = entry.key;
            final items = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Grup (Tanggal)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.grey),
                ...items.map((item) {
                  return ListTile(
                    leading: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item['imageUrl'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      item['name'] ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['category'] ?? 'Unknown',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward, color: Colors.white),
                    onTap: () async {
                      // Navigasi ke FoundDetailScreen (ganti sesuai kebutuhan)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LostDetailScreen(
                            name: item['name'] ?? 'Unknown',
                            location: item['location'] ?? 'Unknown',
                            category: item['category'] ?? 'Unknown',
                            date: item['date'].toDate(),
                            imageUrl: item['imageUrl'] ?? '',
                            imgPath: item['imgPath'] ?? '',
                            itemId: item['itemId'],
                            founderId: item['founderId'],
                            formattedDate:
                                "${item['date'].toDate().day} ${_monthName(item['date'].toDate().month)} ${item['date'].toDate().year}",
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            );
          }).toList();

          // Tampilkan daftar dalam ListView
          return ListView(
            children: dateSections,
          );
        },
      ),
    );
  }

  // Fungsi untuk mendapatkan nama bulan
  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
