// lib/widgets/navbutton.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/utils/colors.dart';

class NavButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text; // <-- 1. Add a text property

  const NavButton({
    super.key,
    required this.onTap,
    required this.text, // <-- 2. Make it a required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
          decoration: ShapeDecoration(
            color: mainColor,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 5),
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
      ),
    );
  }
}
