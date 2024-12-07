import 'package:flutter/material.dart';
import 'package:temuin/screens/authenticate/authenticate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Spasi dari atas layar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.yellow,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Halo, Shofie!',
              style: TextStyle(color: Colors.yellow, fontSize: 24),
            ),
            SizedBox(height: 16),
            buildProfileField(label: "Name", value: "Shofie"),
            buildProfileField(label: "Username", value: "shofwatunniswah14"),
            buildProfileField(
                label: "Email", value: "shofwatunniswah14@gmail.com"),
            buildProfileField(label: "Kontak", value: "+62-8964-3618-332"),
            Spacer(), // Menekan elemen ke atas
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Authenticate
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Authenticate(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Sign Out"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        enabled: false, // Membuat field tidak dapat di-edit
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white),
        controller:
            TextEditingController(text: value), // Mengisi field dengan value
      ),
    );
  }
}
