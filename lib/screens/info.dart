// lib/screens/info.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techguess/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/utils/colors.dart';
import 'package:techguess/widgets/appbar.dart';
import '../widgets/navbutton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InfoScreen extends StatelessWidget {
  final VoidCallback onNext;

  const InfoScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TechGuess',
        backgroundColor: mainColor,
        actions: [
          GestureDetector(
            onTap: () {
              // Dark mode functionality can be added here later
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'lib/assets/icons/dark_mode.svg',
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: body(context),
    );
  }

  Container body(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2D2D3A), Color(0xFF1F1F26)],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 33),
          Container(
                margin: const EdgeInsets.symmetric(horizontal: 33),
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(55.0),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(38.0),
                  decoration: ShapeDecoration(
                    color: mainColor,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(55.0),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: GoogleFonts.angkor(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ).animate().fadeIn(delay: 50.ms),
                      const SizedBox(height: 15),
                      Text(
                        'This is a multiple choice quiz app made to test how deep you are in the tech community, the questions consists on multiple tech brands and what stuff are they producing. Each question consists of 5 different choices, ranging from A to E.',
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(delay: 100.ms),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeInOut),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: NavButton(text: 'Next', onTap: onNext)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms)
                  .slideY(begin: 0.1, end: 0, curve: Curves.easeInOut),
            ),
          ),
        ],
      ),
    );
  }
}
