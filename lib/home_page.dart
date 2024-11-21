import 'package:flutter/material.dart';
import 'found_input.dart'; // Import FoundInputScreen
import 'lost_screen.dart'; // Import LostPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Lost & Found',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tombol untuk Looking for Something
            GestureDetector(
              onTap: () {
                // Navigasi ke FoundInputScreen ketika ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LostPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color.fromARGB(255, 255, 204, 0),
                child: const Center(
                  child: Text(
                    'Looking for Something?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Tombol untuk Found Something
            GestureDetector(
              onTap: () {
                // Navigasi ke LostPage ketika ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoundInputScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: const Color.fromARGB(255, 255, 204, 0),
                child: const Center(
                  child: Text(
                    'Found Something?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
