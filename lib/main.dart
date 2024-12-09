import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temuin/screens/pages/home_page.dart';
import 'package:temuin/screens/pages/found_input.dart';
import 'package:temuin/screens/pages/lost/lost_screen.dart';
import 'package:temuin/screens/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:temuin/screens/pages/taken/taken_screen.dart';
import 'package:temuin/screens/pages/wrapper.dart';
import 'package:temuin/services/auth.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await supabase.Supabase.initialize(
    url: "https://skjgwoyuftuidjvqbjkn.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNramd3b3l1ZnR1aWRqdnFiamtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM3NTU3OTQsImV4cCI6MjA0OTMzMTc5NH0.Khcp1rLOwmZzVE0lQKwEXiCppIdpN7Z6VL6oWcvNfSo",
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
  int _currentIndex = 2;

  final List<Widget> _children = [
    LostPage(),
    FoundInputScreen(),
    HomePage(),
    TakenPage(),
    ProfileScreen(),
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: const Color.fromARGB(255, 255, 204, 0),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Lost'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Found'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Taken'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}
