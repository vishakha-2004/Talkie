import 'package:chatflash/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatflash/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../Buttons.dart';


class StartScreen extends StatefulWidget {
  static String id = 'start_screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.grey,end: Colors.white).animate(controller);

    controller.forward();

    animation.addListener((){
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Row(
                children:[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child:
                        SizedBox(
                          height: controller.value  * 100,
                          child: Image.asset('images/chat1.png'),
                        ),
                      ),
                   ),
                      TypewriterAnimatedTextKit(
                         text: ['Talkie'],
                        textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      ),
                    ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons(
              text: 'Login',
              color: Colors.blue,
              onClick:() {
                Navigator.pushNamed(context, LoginScreen.id);
              }
            ),
            Buttons(
                text: 'Register',
              color: Colors.blue,
              onClick: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegistrationScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}