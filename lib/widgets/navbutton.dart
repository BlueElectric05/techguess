// lib/widgets/next_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Using the color from your existing code
var mainColor = Color(0xFF3E3D50);

class NavButton extends StatelessWidget {
  final VoidCallback onTap; // A function to be called when the button is tapped
  final String text;       // The text to display on the button

  const NavButton({
    super.key,
    required this.onTap,
    this.text = 'Next', // Default text is 'Next'
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
