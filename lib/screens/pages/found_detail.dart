import 'package:flutter/material.dart';
import 'package:temuin/screens/pages/found_edit.dart';
import 'package:temuin/services/auth.dart';
import 'package:temuin/services/database.dart';

class FoundDetailScreen extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final DateTime date;
  final String image;
  final String itemId;
  final String founderId;
  final String formattedDate;

  const FoundDetailScreen(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.date,
      required this.image,
      required this.itemId,
      required this.founderId,
      required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final userId = AuthService().getCurrentUser()?.uid;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                image, // Path to your asset image
                width: screenWidth * 0.4, // 40% of the screen width
                height: screenWidth * 0.4, // 40% of the screen width
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of the screen height

            // Name Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                initialValue: name,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            // Location Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                initialValue: location,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            // Category Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                initialValue: category,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            // Date Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                initialValue: formattedDate,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Adjust the padding as needed
                    child: Icon(Icons.calendar_today, color: Colors.white),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            // Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Tampilkan modal konfirmasi
                      bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text(
                                'make sure the item you are going to take is really yours'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Tidak jadi
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Konfirmasi
                                },
                                child: Text('Take'),
                              ),
                            ],
                          );
                        },
                      );

                      // Jika pengguna menekan "Ambil"
                      if (confirm == true) {
                        dynamic result = await DatabaseService(uid: userId)
                            .takeLostItem(itemId);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to take item.'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else if (result == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item successfully taken.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    icon: Image.asset('assets/take.png'),
                    label: const Text("Take"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.015),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (userId != founderId) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'only the person who found the item can edit it.'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoundEditScreen(
                                    name: name,
                                    category: category,
                                    location: location,
                                    date: date,
                                    image: image,
                                    formattedDate: formattedDate,
                                    itemId: itemId,
                                  )),
                        );
                      }
                    },
                    icon: const Icon(Icons.edit, color: Colors.black),
                    label: const Text("Edit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.015),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: screenHeight * 0.03), // Additional spacing at bottom
          ],
        ),
      ),
    );
  }
}
