import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Temuin/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan pengguna saat ini
    final user = _auth.getCurrentUser();

    if (user == null) {
      return const Center(child: Text('User not logged in.'));
    }

    return StreamBuilder<DocumentSnapshot>(
      // Ambil dokumen berdasarkan uid pengguna saat ini
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found.'));
        }

        // Mendapatkan data pengguna dari snapshot
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final phone = userData['phone'] ?? 'No Phone';

        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40), // Spasi dari atas layar
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 255, 204, 0),
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Text(
                  'Halo, ${user.displayName}!',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 204, 0), fontSize: 24),
                ),
                const SizedBox(height: 16),
                buildProfileField(label: "Name", value: user.displayName ?? ''),
                buildProfileField(label: "Email", value: user.email ?? ''),
                buildProfileField(label: "Phone", value: phone),
                const Spacer(), // Menekan elemen ke atas
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
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
      },
    );
  }

  Widget buildProfileField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        enabled: false, // Membuat field tidak dapat di-edit
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        controller:
            TextEditingController(text: value), // Mengisi field dengan value
      ),
    );
  }
}
