import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  String text;
  Color color;
  Function() onClick;

  Buttons({required this.text, required this.color, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context){
            //   return LoginScreen();
            // }));
            // Navigator.pushNamed(context, LoginScreen.id);
            onClick();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: Size(200.0, 50.0),
          ),
          child: Text(text,
              style: TextStyle(color: Colors.white)
          ),
        )
    );
  }
}