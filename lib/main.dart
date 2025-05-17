import 'package:chatflash/screens/AuthWrapper.dart';
import 'package:chatflash/screens/StartScreen.dart';
import 'package:chatflash/screens/chat_screen.dart';
import 'package:chatflash/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatflash/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "YOUR_API_KEY",
            authDomain: "YOUR_AUTH_DOMAIN",
            projectId: "YOUR_PROJECT_ID",
            storageBucket: "YOUR_STORAGE_BUCKET",
            messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
            appId: "YOUR_APP_ID",
          ),
        );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: StartScreen(),

      home: AuthWrapper(),
      //initialRoute: 'start_screen',
      routes: {
       // start_screen':(context) => StartScreen(),
        StartScreen.id:(context) => StartScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        'register_screen':(context) => RegistrationScreen(),
        // 'chat_screen':(context) => ChatScreen(),
      },
    );
  }
}
