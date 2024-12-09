import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Untuk autentikasi pengguna
import 'package:cloud_firestore/cloud_firestore.dart'; // Untuk Firestore
import 'package:temuin/services/auth.dart';
import 'package:temuin/services/database.dart';

class LostEditScreen extends StatefulWidget {
  final String name;
  final String category;
  final String location;
  final DateTime date;
  final String image;
  final String formattedDate;
  final String itemId;

  const LostEditScreen({
    super.key,
    required this.name,
    required this.category,
    required this.location,
    required this.date,
    required this.image,
    required this.formattedDate,
    required this.itemId,
  });

  @override
  LostEditScreenState createState() => LostEditScreenState();
}

class LostEditScreenState extends State<LostEditScreen> {
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController locationController;
  late TextEditingController dateController;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dan tanggal
    nameController = TextEditingController(text: widget.name);
    categoryController = TextEditingController(text: widget.category);
    locationController = TextEditingController(text: widget.location);
    dateController = TextEditingController(text: widget.formattedDate);
    selectedDate = widget.date;
  }

  @override
  void dispose() {
    // Pastikan untuk membersihkan controller ketika halaman dibuang
    nameController.dispose();
    categoryController.dispose();
    locationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan Date Picker
  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 255, 204, 0),
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color.fromARGB(247, 21, 21, 21),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text =
            "${selectedDate.day} ${_monthName(selectedDate.month)} ${selectedDate.year}";
      });
    }
  }

  // Fungsi untuk mendapatkan nama bulan
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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Fungsi untuk menyimpan item
    void editItem() async {
      if (_formKey.currentState!.validate()) {
        try {
          await DatabaseService().editItem(
            widget.itemId,
            nameController.text,
            locationController.text,
            categoryController.text,
            selectedDate,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item edited successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to edit item: $e')),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
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
          widget.name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    widget.image,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _CustomTextField(
                label: 'Name',
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                label: 'Location',
                controller: locationController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                label: 'Category',
                controller: categoryController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a category' : null,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                label: 'Date',
                controller: dateController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a date' : null,
                prefixIcon: Icons.calendar_today,
                onTap: selectDate,
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
                      foregroundColor: const Color.fromARGB(255, 255, 204, 0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 255, 204, 0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: editItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 204, 0),
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
