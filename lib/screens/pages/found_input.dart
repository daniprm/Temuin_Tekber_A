import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temuin/services/database.dart';

class FoundInputScreen extends StatefulWidget {
  const FoundInputScreen({super.key});

  @override
  State<FoundInputScreen> createState() => _FoundInputScreenState();
}

class _FoundInputScreenState extends State<FoundInputScreen> {
  // TextEditingControllers untuk setiap TextField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // final ImagePicker _picker = ImagePicker();
  // File? selectedImage; // Menyimpan file gambar

  final _formKey = GlobalKey<FormState>(); // Key untuk form validation
  DateTime date = DateTime.now();

  // Fungsi untuk memunculkan Date Picker
  Future<void> selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 255, 204, 0), // Warna header
              onPrimary: Colors.black, // Warna teks header
              surface: Colors.black, // Warna background picker
              onSurface: Colors.white, // Warna teks picker
            ),
            dialogBackgroundColor: const Color.fromARGB(247, 21, 21, 21),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
        dateController.text =
            "${date.day} ${_monthName(date.month)} ${date.year}"; // Format tanggal
      });
    }
  }

  // Fungsi untuk menambahkan item
  void addItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ambil UID pengguna saat ini
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          throw Exception("User not authenticated");
        }

        // Data yang akan disimpan
        final itemData = {
          'name': nameController.text,
          'location': locationController.text,
          'category': categoryController.text,
          'date': DateTime.parse(date.toIso8601String()), // Format tanggal
          'founderId': currentUser.uid, // Tambahkan founderId
          'isTaken': false,
          'createdAt': FieldValue.serverTimestamp(), // Waktu server
        };

        // Tambahkan data ke Firestore
        DatabaseService().addLostItems(itemData);

        // Berikan notifikasi berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully!')),
        );

        // Reset form dan state
        _formKey.currentState!.reset();
        nameController.clear();
        locationController.clear();
        categoryController.clear();
        dateController.clear();
        setState(() {
          date = DateTime.now();
        });
      } catch (e) {
        // Tampilkan pesan error jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add item: $e')),
        );
      }
    }
  }

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
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CustomTextField(
                  label: 'Name',
                  controller: nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                _CustomTextField(
                  label: 'Location',
                  controller: locationController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a location' : null,
                ),
                _CustomTextField(
                  label: 'Category',
                  controller: categoryController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a category' : null,
                ),
                _CustomTextField(
                  label: 'Date',
                  controller: dateController,
                  prefixIcon: Icons.calendar_today,
                  onTap: selectDate, // Panggil fungsi date picker
                  validator: (value) =>
                      value!.isEmpty ? 'Please select a date' : null,
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
                    onPressed: () {
                      // Tambahkan logika upload file
                    },
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
                    onPressed: addItem,
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
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  const _CustomTextField({
    required this.label,
    this.prefixIcon,
    this.controller,
    this.onTap,
    this.validator,
  });

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
        TextFormField(
          validator: validator,
          controller: controller,
          readOnly:
              onTap != null, // Nonaktifkan input manual jika onTap disediakan
          onTap: onTap, // Panggil onTap jika tersedia
          style: const TextStyle(color: Colors.white, height: 1),
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white)
                : null,
            filled: true,
            fillColor: const Color.fromRGBO(98, 98, 98, 1),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}
