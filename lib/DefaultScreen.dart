import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatefulWidget {
  //constructor
  DefaultScreen(this.screenWidth, this.screenHeight);

  var screenWidth;
  var screenHeight;

  @override
  State<StatefulWidget> createState() {
    return DefaultScreenState(screenWidth, screenHeight);
  }
}

class DefaultScreenState extends State<DefaultScreen> {
  //constructor
  DefaultScreenState(this.screenWidth, this.screenHeight);

  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.blue[50],
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: screenWidth * 0.1),
              width: screenWidth * 0.8,
              height: screenHeight * 0.2,
              child: Text(
                'Welcome Admin!',
                style: TextStyle(color: Colors.blue[900], fontSize: 24),
              ),
              alignment: Alignment.center,
            ),
            Container(
              width: screenWidth * 0.8,
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
              ),
              child: Icon(
                Icons.admin_panel_settings,
                color: Colors.green,
                size: 150.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
