import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/screens/info.dart';
import 'package:techguess/screens/login.dart';
import 'package:techguess/screens/quiz.dart';

void main() {
  runApp(const MyApp());
}

class Question {
  final String text;
  final List<String> choices;
  final int correctChoiceIndex;
  final String difficulty;
  final String? imageUrl; // Optional image URL

  const Question({
    required this.text,
    required this.choices,
    required this.correctChoiceIndex,
    required this.difficulty,
    this.imageUrl,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // --- State Management ---
  String? _userName;
  int _userScore = 0;
  double? _finalScore;

  // This string controls which  is currently visible
  String _currentScreen = 'info';

  void _showInfoScreen() {
    setState(() {
      _currentScreen = 'info';
    });
  }

  // --- Question Data ---
  final List<Question> _questions = [
    Question(
        text: 'Which company developed the "M1" chip?',
        choices: ['A. Intel', 'B. AMD', 'C. Apple', 'D. NVIDIA', 'E. Nintendo'],
        correctChoiceIndex: 2,
        difficulty: 'easy'),
    Question(
        text: 'What is the logo shown in the image?',
        choices: ['GitHub', 'GitLab', 'Bitbucket', 'Docker'],
        correctChoiceIndex: 0,
        imageUrl: 'https://i.imgur.com/O4yP62s.png',
        difficulty: 'easy'),
    Question(
        text: 'The Dart programming language is developed by which company?',
        choices: ['Microsoft', 'Google', 'Facebook', 'Oracle'],
        correctChoiceIndex: 1,
        difficulty: 'easy'),
  ];


  void _showLogin() {
    setState(() {
      _currentScreen = 'login';
    });
  }

  void _startQuiz(String userName) {
    setState(() {
      _userName = userName;
      _currentScreen = 'quiz';
      resetQuiz();
    });
  }

  /// Call this when a user answers a question correctly.
  void _answerCorrectly() {
    setState(() {
      _userScore++;
    });
  }

  /// Calculates the final score and returns to the info screen.
  void _calculateFinalScore() {
    setState(() {
      _finalScore = (_userScore / _questions.length) * 10;
      _currentScreen = 'info';
    });
    print('User answered $_userScore questions correctly.');
    print('Final score: ${_finalScore?.toStringAsFixed(1)} / 10');
  }

  void resetQuiz() {
    setState(() {
      _userScore = 0;
      _finalScore = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (_currentScreen == 'quiz') {
      screen = QuizScreen(
        userName: _userName ?? 'Player',
        questions: _questions,
        onQuizComplete: _calculateFinalScore,
        onAnswerCorrect: _answerCorrectly,
      );
    } else if (_currentScreen == 'login') {
      screen = LoginScreen(
        onLogin: _startQuiz,
        onBack: _showInfoScreen,
      );
    } else {
      screen = InfoScreen(onNext: _showLogin);
    }

    return MaterialApp(
      title: 'Tech Guess',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: screen,
    );
  }
}
