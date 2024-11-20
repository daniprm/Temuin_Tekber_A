import 'package:flutter/material.dart';

class FoundInputScreen extends StatelessWidget {
  const FoundInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Found Input',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CustomTextField(label: 'Name'),
            const SizedBox(height: 22),
            const _CustomTextField(label: 'Location'),
            const SizedBox(height: 22),
            const _CustomTextField(label: 'Category'),
            const SizedBox(height: 22),
            const _CustomTextField(
              label: 'Date',
              prefixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 22),
            const Text(
              'Upload Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
              padding: const EdgeInsets.only(bottom: 150),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 204, 0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Add Item',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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

  const _CustomTextField({required this.label, this.prefixIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, height: 1),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 17),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.white) : null,
        filled: true,
        fillColor: const Color.fromRGBO(98, 98, 98, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
