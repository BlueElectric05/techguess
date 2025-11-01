import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/screens/info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Guess',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
        debugShowCheckedModeBanner: false,
        home: const InfoScreen(),
    );
  }
}