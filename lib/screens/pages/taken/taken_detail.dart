import 'package:flutter/material.dart';
import 'package:temuin/services/auth.dart';
import 'package:temuin/services/database.dart';

class TakenDetailScreen extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final DateTime date;
  final String image;
  final String itemId;
  final String founderId;
  final String formattedDate;
  final String formattedTakenDate;
  final String takenBy;

  const TakenDetailScreen(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.date,
      required this.image,
      required this.itemId,
      required this.founderId,
      required this.formattedDate,
      required this.formattedTakenDate,
      required this.takenBy});

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
              child: Image.network(
                image,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of the screen height

            // Name Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: name),
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
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: location),
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
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: category),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: takenBy),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Taken By',
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
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: formattedDate),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Lost Date',
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: formattedTakenDate),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Taken Date',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Tampilkan modal konfirmasi
                      bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Restore the item?'),
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
                                child: Text('Restore'),
                              ),
                            ],
                          );
                        },
                      );

                      // Jika pengguna menekan "Ambil"
                      if (confirm == true) {
                        dynamic result = await DatabaseService(uid: userId)
                            .restoreTakenItem(itemId);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to Restore item.'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else if (result == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item successfully Restored.'),
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
                    icon: Icon(Icons.restore_from_trash),
                    label: const Text("Restore"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.015),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (userId != founderId) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'only the person who found the item can delete it.'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      } else {
                        // Tampilkan modal konfirmasi
                        bool? confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text(
                                  'the item will be permanently deleted. Are you sure want to delete the item?'),
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
                                    Navigator.of(context)
                                        .pop(true); // Konfirmasi
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        // Jika pengguna menekan "Ambil"
                        if (confirm == true) {
                          dynamic result = await DatabaseService(uid: userId)
                              .deleteItem(itemId);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to Delete item.'),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else if (result == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item successfully Deleted.'),
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
                      }
                    },
                    icon: Icon(Icons.delete),
                    label: const Text("Delete"),
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
