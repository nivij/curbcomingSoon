import 'package:flutter/material.dart';
import 'flip_card_page.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
          backgroundColor: Color(0XFF3D1CCF),
leadingWidth: 159,
        leading: Image.asset('assets/appbar.png',),
      ),
      backgroundColor: Color(0XFF3D1CCF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300, // Adjust the height as needed
            child: FlipCardPage(),
          ),

        ],
      ),
    );
  }
}
