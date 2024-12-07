import 'package:flutter/material.dart';

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
      String formattedDate =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      dateController.text = formattedDate; // Update controller dengan tanggal
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
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CustomTextField(label: 'Name', controller: nameController),
            _CustomTextField(label: 'Location', controller: locationController),
            _CustomTextField(label: 'Category', controller: categoryController),
            _CustomTextField(
              label: 'Date',
              controller: dateController,
              prefixIcon: Icons.calendar_today,
              onTap: selectDate, // Panggil fungsi date picker
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
  final TextEditingController? controller;
  final VoidCallback? onTap; // Callback untuk menambahkan logika onTap

  const _CustomTextField({
    required this.label,
    this.prefixIcon,
    this.controller,
    this.onTap,
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
        TextField(
          controller: controller,
          readOnly: onTap != null, // Nonaktifkan input manual jika onTap disediakan
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
