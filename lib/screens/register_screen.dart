import 'package:chatflash/Buttons.dart';
import 'package:chatflash/constants.dart';
import 'package:chatflash/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String errorMsg = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/chat1.png'),
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Username'),
              ),
              SizedBox(height: 8.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                onChanged: (value) {
                    password = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(height: 24.0),

              if(errorMsg.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(errorMsg,style: TextStyle(color: Colors.red),),
                ),

              Buttons(
                text: 'Register',
                color: Colors.blue,
                onClick: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser.user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(newUser.user!.uid)
                          .set({
                        'email': email,
                        'username': username,
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    }
                  } catch (e) {
                    String message = '';
                    if(e is FirebaseAuthException){
                      message = e.message ?? message;
                    }
                    setState(() {
                      errorMsg = message;
                    });

                  }finally{
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
