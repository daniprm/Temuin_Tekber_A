import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temuin/screens/pages/home_page.dart';
import 'package:temuin/screens/pages/found_input.dart';
import 'package:temuin/screens/pages/lost_screen.dart';
import 'package:temuin/screens/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:temuin/screens/pages/wrapper.dart';
import 'package:temuin/services/auth.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Temuin());
}

class Temuin extends StatelessWidget {
  const Temuin({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: MaterialApp(
        home: const Wrapper(),
        theme: ThemeData.dark(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final AuthService _auth = AuthService();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    const LostPage(),
    const FoundInputScreen(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 21, 21, 1),
      body: _children[_currentIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 255, 204, 0),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: onTabTapped, // Menangani klik
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Lost'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Found'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}
