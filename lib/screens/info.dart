// lib/screens/info.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbutton.dart'; // <-- Import the new button widget


var mainColor = Color(0xFF3E3D50);
var secondColor = Color(0xFF2D2D3A);
var gradOutline = LinearGradient(colors: [Color(0xFF6A7087), Color(0xFF23232C)]);

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(),
      body: body(),

    );
  }

  Container body() {
    return Container(
      width: double.infinity, // Ensures the Column can center its children properly
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D2D3A),
              Color(0xFF1F1F26),
            ]
        ),
      ),
      child: Column(
        // Removed alignment properties to allow natural top alignment
        children: [
          SizedBox(height: 33),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 33),
            padding: const EdgeInsets.all(38.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 3),
                  spreadRadius: 5,
                  blurRadius: 7,
                )
              ],
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.circular(20),
              color: mainColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  'About',
                  style: GoogleFonts.angkor(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'This is a multiple choice quiz app made to test how deep you are in the tech community, the questions consists on multiple tech brands and what stuff are they producing. Each question consists of 5 different choices, ranging from A to E.',
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5, // Improves line spacing for readability
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40), // <-- Added space above the button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0), // Match the container's margin
            child: Align(
              alignment: Alignment.centerRight,
              child: NavButton(
                onTap: () {
                  // TODO: Add navigation logic here
                  print("Next button tapped!");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  AppBar appBar() {
    return AppBar(
      title: Text('TechGuess',
        style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.angkor().fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 20
        ),
      ),
      backgroundColor: mainColor,
      actions: [
        GestureDetector(
          onTap: (){
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset('lib/assets/icons/dark_mode.svg', height: 30, width: 30),
          ),
        )
      ],
    );
  }
}
