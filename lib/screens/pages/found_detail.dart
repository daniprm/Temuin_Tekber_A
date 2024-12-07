import 'package:flutter/material.dart';
import 'package:temuin/screens/pages/found_edit.dart';
import 'package:temuin/screens/pages/lost_screen.dart';

class FoundDetailScreen extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final String date;
  final String image;

  const FoundDetailScreen(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.date,
      required this.image});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                initialValue: date,
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
                    onPressed: () {},
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoundEditScreen(
                                  name: name,
                                  category: category,
                                  location: location,
                                  date: date,
                                  image: image,
                                )),
                      );
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
