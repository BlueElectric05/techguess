// lib/widgets/custom_appbar.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.angkor().fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      backgroundColor: backgroundColor,
      actions: actions,
      elevation: 0, // A common practice for modern UI to remove the shadow
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
