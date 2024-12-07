import 'package:flutter/material.dart';

class FoundInputScreen extends StatelessWidget {
  const FoundInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Found Input',
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
            const _CustomTextField(label: 'Name'),
            const _CustomTextField(label: 'Location'),
            const _CustomTextField(label: 'Category'),
            const _CustomTextField(
              label: 'Date',
              prefixIcon: Icons.calendar_today,
            ),
            const Text(
              'Upload Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 180),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Color.fromARGB(255, 255, 204, 0), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: const Text(
                  'Select File',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 204, 0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Add Item',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
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

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;

  const _CustomTextField({required this.label, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          style: const TextStyle(color: Colors.white, height: 1),
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white)
                : null,
            filled: true,
            fillColor: const Color.fromRGBO(98, 98, 98, 1),
            isDense: true, // Menjadikan TextField lebih ramping
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15, // Padding vertikal lebih kecil
              horizontal: 12, // Padding horizontal
            ),
            // Mengatur outline berwarna putih
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Colors.white, width: 1), // Outline putih
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Colors.white, width: 1), // Outline putih saat aktif
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Colors.white, width: 1), // Outline putih saat fokus
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
