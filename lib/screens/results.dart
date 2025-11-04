import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/utils/colors.dart';
import 'package:techguess/widgets/appbar.dart';
import '../widgets/navbutton.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int userScore;
  final int totalQuestions;
  final String rank;
  final VoidCallback onPlayAgain;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.userScore,
    required this.totalQuestions,
    required this.onPlayAgain,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final double finalScore = (totalQuestions > 0)
        ? (userScore / totalQuestions) * 10
        : 0;

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
      body: Container(
        padding: EdgeInsets.all(33),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D2D3A), Color(0xFF1F1F26)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildResultsCard(
                  userName: userName,
                  finalScore: finalScore.toStringAsFixed(1),
                  userScore: userScore,
                  totalQuestions: totalQuestions,
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeInOut),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 33),
                child: NavButton(text: 'Play Again', onTap: onPlayAgain)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .slideY(begin: 0.5, end: 0, curve: Curves.easeInOut),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard({
    required String userName,
    required String finalScore,
    required int userScore,
    required int totalQuestions,
  }) {
    return Container(
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(55.0),
          side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Congratulations, $userName!',
              textAlign: TextAlign.center,
              style: GoogleFonts.angkor(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Rank: $rank',
              style: GoogleFonts.dmSans(color: textColor, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '$finalScore / 10',
              style: GoogleFonts.dmSans(
                color: textColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'You answered $userScore out of $totalQuestions questions correctly.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: textColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
