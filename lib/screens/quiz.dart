import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/main.dart'; // Import to use the 'Question' class
import 'package:techguess/utils/colors.dart';
import 'package:techguess/widgets/appbar.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  final List<Question> questions;
  final VoidCallback onQuizComplete; // Function to call when quiz ends
  final VoidCallback onAnswerCorrect;  // Function to call for a correct answer

  const QuizScreen({
    super.key,
    required this.userName,
    required this.questions,
    required this.onQuizComplete,
    required this.onAnswerCorrect,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  int _currentQuestionIndex = 0;
  int? _selectedChoiceIndex; // Tracks the user's choice for the current question

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Called when the user taps a choice
  void _handleAnswer(int choiceIndex) {
    // Prevent changing the answer after selecting one
    if (_selectedChoiceIndex != null) return;

    setState(() {
      _selectedChoiceIndex = choiceIndex;
    });

    // Check if the answer is correct and call the callback from main.dart
    if (choiceIndex == widget.questions[_currentQuestionIndex].correctChoiceIndex) {
      widget.onAnswerCorrect();
    }

    // Wait a moment before automatically scrolling to the next question
    Future.delayed(const Duration(milliseconds: 800), () {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        // Move to the next page
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        // This is the last question, so complete the quiz
        widget.onQuizComplete();
        // The navigation will be handled by MyApp's state change
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TechGuess',
        backgroundColor: mainColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D2D3A), Color(0xFF1F1F26)],
          ),
        ),
        // PageView handles horizontal scrolling
        child: PageView.builder(
          controller: _pageController,
          // Disable manual swiping
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentQuestionIndex = index;
              _selectedChoiceIndex = null; // Reset choice for the new question
            });
          },
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            final question = widget.questions[index];
            return _buildQuestionCard(question);
          },
        ),
      ),
    );
  }

  // Builds the UI for a single question
  Widget _buildQuestionCard(Question question) {
    return Padding(
      padding: const EdgeInsets.all(33.0),
      child: Container(
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
              )
            ],
          ),
          // 1. WRAP THE COLUMN WITH A SingleChildScrollView
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1}/${widget.questions.length}',
                  style: GoogleFonts.angkor(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Difficulty: ${question.difficulty}',
                  style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  question.text,
                  style: GoogleFonts.dmSans(color: Colors.white, fontSize: 15, height: 1.4),
                ),
                const SizedBox(height: 20),

                // Image display
                if (question.imageUrl != null && question.imageUrl!.isNotEmpty)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(question.imageUrl!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                // Add some space before the choices
                const SizedBox(height: 20),

                // Generate choice buttons
                ...List.generate(question.choices.length, (index) {
                  return _buildChoiceButton(
                    text: question.choices[index],
                    index: index,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds a single choice button with dynamic coloring
// Builds a single choice button with dynamic coloring
  Widget _buildChoiceButton({required String text, required int index}) {
    Color buttonColor = secondColor;
    bool isSelected = _selectedChoiceIndex == index; // <-- CORRECTED
    bool isCorrect = index == widget.questions[_currentQuestionIndex].correctChoiceIndex;

    if (_selectedChoiceIndex != null) { // If an answer has been given
      if (isSelected) {
        buttonColor = isCorrect ? Colors.green.shade700 : Colors.red.shade700;
      } else if (isCorrect) {
        buttonColor = Colors.green.shade700; // Show the correct answer
      }
    }

    return GestureDetector(
      onTap: () => _handleAnswer(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
