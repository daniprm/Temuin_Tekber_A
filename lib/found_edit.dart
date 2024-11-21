import 'package:flutter/material.dart';

class FoundEditScreen extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final String date;
  final String image;

  const FoundEditScreen(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.date,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 204, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  image,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(label: 'Name', initialValue: name),
            const SizedBox(height: 16),
            _buildInputField(label: 'Location', initialValue: location),
            const SizedBox(height: 16),
            _buildInputField(label: 'Category', initialValue: category),
            const SizedBox(height: 16),
            _buildInputField(
              label: 'Date',
              initialValue: date,
              prefixIcon: Icons.calendar_today,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 255, 204, 0),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 255, 204, 0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                  ),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan fungsi simpan di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 204, 0),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    String? initialValue,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
