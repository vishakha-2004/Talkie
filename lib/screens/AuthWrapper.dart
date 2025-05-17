import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chatflash/screens/StartScreen.dart';
import 'package:chatflash/screens/chat_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Logged in
      return ChatScreen();
    } else {
      // Not logged in
      return StartScreen();
    }
  }
}
