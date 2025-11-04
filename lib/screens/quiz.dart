import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/main.dart';
import 'package:techguess/utils/colors.dart';
import 'package:techguess/widgets/appbar.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  final List<Question> questions;
  final VoidCallback onQuizComplete;
  final VoidCallback onAnswerCorrect;

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
  int?
  _selectedChoiceIndex;

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

  void _handleAnswer(int choiceIndex) {
    if (_selectedChoiceIndex != null) return;

    setState(() {
      _selectedChoiceIndex = choiceIndex;
    });

    if (choiceIndex ==
        widget.questions[_currentQuestionIndex].correctChoiceIndex) {
      widget.onAnswerCorrect();
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        widget.onQuizComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'TechGuess', backgroundColor: mainColor),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D2D3A), Color(0xFF1F1F26)],
          ),
        ),
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentQuestionIndex = index;
              _selectedChoiceIndex = null;
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

  Widget _buildQuestionCard(Question question) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 33.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 33.0),
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(55.0),
                side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(30.0),
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
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    question.text,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Image display (remains inside the card)
                  if (question.imageUrl != null && question.imageUrl!.isNotEmpty)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 150,
                        decoration: ShapeDecoration(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(question.imageUrl!),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),


          const SizedBox(height: 33),

          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.all(15.0),
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(55.0),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                  ),
                ),
              color: mainColor,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 3),
                  spreadRadius: 5,
                  blurRadius: 7,
                )
              ],
            ),
            child: Column(
              children: List.generate(question.choices.length, (index) {
                return _buildChoiceButton(
                  text: question.choices[index],
                  index: index,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildChoiceButton({required String text, required int index}) {
    Color buttonColor = secondColor;
    bool isSelected = _selectedChoiceIndex == index;
    bool isCorrect =
        index == widget.questions[_currentQuestionIndex].correctChoiceIndex;

    if (_selectedChoiceIndex != null) {
      if (isSelected) {
        buttonColor = isCorrect ? Colors.green.shade700 : Colors.red.shade700;
      } else if (isCorrect) {
        buttonColor = Colors.green.shade700;
      }
    }

    return GestureDetector(
      onTap: () => _handleAnswer(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white.withOpacity(0.3), width: 2),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.left,
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
