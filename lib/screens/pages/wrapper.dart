import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temuin/main.dart';
import 'package:temuin/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:temuin/screens/authenticate/verifyEmail.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // Return either pages or authenticate widget
    if (user == null) {
      return const Authenticate();
    } else if (!user.emailVerified) {
      return const VerifyEmail();
    } else {
      return HomeScreen();
    }
  }
}
