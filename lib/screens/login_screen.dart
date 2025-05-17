import 'package:chatflash/Buttons.dart';
import 'package:chatflash/constants.dart';
import 'package:chatflash/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String errorMsg = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              if (errorMsg.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    errorMsg,
                    style: TextStyle(color: Colors.red),
                  ),
                ),


              Buttons(text: 'Login',
                color: Colors.blue,
                onClick: () async {
                  setState(() {
                    showSpinner = true;
                    errorMsg = '';
                  });
                  try{
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password
                    );
                    if(user != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ChatScreen();
                      }));
                    }
                  } catch(e){
                    String message = '';
                    if (e is FirebaseAuthException) {
                      message = e.message ?? message; //user-friendly error
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
