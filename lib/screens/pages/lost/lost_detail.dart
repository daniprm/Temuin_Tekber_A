import 'package:flutter/material.dart';
import 'package:Temuin/screens/pages/lost/lost_edit.dart';
import 'package:Temuin/services/auth.dart';
import 'package:Temuin/services/database.dart';

class LostDetailScreen extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final DateTime date;
  final String imageUrl;
  final String imgPath;
  final String itemId;
  final String founderId;
  final String formattedDate;

  const LostDetailScreen(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.date,
      required this.imageUrl,
      required this.imgPath,
      required this.itemId,
      required this.founderId,
      required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final user = AuthService().getCurrentUser();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Item Details',
          style: TextStyle(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                initialValue: user?.displayName,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Found By',
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
                initialValue: formattedDate,
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
                    onPressed: () async {
                      final confirm = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => const NameConfirmationDialog(),
                      );

                      if (confirm != null && confirm['confirmed'] == true) {
                        dynamic result = await DatabaseService(uid: user?.uid)
                            .takeLostItem(itemId, confirm['name']);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to take item.'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else if (result == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item successfully taken.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
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
                      if (user?.uid != founderId) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'only the person who found the item can edit it.'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LostEditScreen(
                                    name: name,
                                    category: category,
                                    location: location,
                                    date: date,
                                    imageUrl: imageUrl,
                                    imgPath: imgPath,
                                    formattedDate: formattedDate,
                                    itemId: itemId,
                                  )),
                        );
                      }
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

class NameConfirmationDialog extends StatefulWidget {
  const NameConfirmationDialog({Key? key}) : super(key: key);

  @override
  State<NameConfirmationDialog> createState() => _NameConfirmationDialogState();
}

class _NameConfirmationDialogState extends State<NameConfirmationDialog> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'Make sure the item you are going to take is really yours.'),
          const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'confirmed': false,
              'name': null,
            }); // Action canceled
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final name = _nameController.text.trim();
            if (name.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter your name')),
              );
            } else {
              Navigator.of(context).pop({
                'confirmed': true,
                'name': name,
              }); // Action confirmed with name
            }
          },
          child: const Text('Take'),
        ),
      ],
    );
  }
}
