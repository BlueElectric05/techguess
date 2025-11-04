import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/screens/info.dart';
import 'package:techguess/screens/login.dart';
import 'package:techguess/screens/quiz.dart';
import 'package:techguess/screens/results.dart';

void main() {
  runApp(const MyApp());
}

class Question {
  final String text;
  final List<String> choices;
  final int correctChoiceIndex;
  final String difficulty;
  final String? imageUrl;

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
  String? rank;

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
        text: 'in September 23, 2008, the first ever Android phone was released. What’s the name of the phone model?',
        choices: ['A. HTC One', 'B. HTC Dream', 'C. iPhone 2G', 'D. iPad', 'E. Samsung Galaxy S'],
        correctChoiceIndex: 1,
        difficulty: 'easy'),
    Question(
        text: "Before iOS, iPhone's operating system was called:",
        choices: ['A. Iphone OS', 'B. Linux', 'C. TempleOS', 'D. Windows', 'E. Android'],
        correctChoiceIndex: 0,
        difficulty: 'very easy'),
    Question(
        text: 'This is a computer that was revolutionary in the 80s, especially in UK and US, what is this?',
        choices: ['A. Atari ST', 'B. Macintosh', 'C. Commodore 64', 'D. Apple II', 'E. IBM PCjr'],
        correctChoiceIndex: 2,
        imageUrl: 'https://th.bing.com/th/id/R.60699a31c2617ba297b89d708be7638c?rik=0fInGh1q7nKUYQ&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2f9%2f9d%2fCommodore64.jpg&ehk=sBnh1engyRrM00UhpGbTFKng9%2bYa2F93u1JLNpt3CuQ%3d&risl=&pid=ImgRaw&r=0',
        difficulty: 'medium'),
    Question(
        text: "The first ever computer to have a cursor feature was:",
        choices: ['A. Apple II', 'B. Macintosh', 'C. Commodore PET', 'D. Commodore Amiga', 'E. Xerox Alto'],
        correctChoiceIndex: 4,
        difficulty: 'hard'),
    Question(
        text: "This is one of Apple's fairly obscure product, what is this?",
        choices: ['A. Dreamcast', 'B. Saturn', 'C. Pippin', 'D. PC-FX', 'E. PC-Engine'],
        correctChoiceIndex: 2,
        imageUrl: 'https://cs4.pikabu.ru/post_img/big/2016/08/31/6/1472634438154126597.jpg',
        difficulty: 'hard'),
    Question(
        text: "What does IaaS stands for?",
        choices: ['A. Infrastructure as a Service','B. Platform as a Service', 'C. Software as a Service', 'D. Cloud Computing', 'E. Entity Relationship Diagram'],
        correctChoiceIndex: 0,
        difficulty: 'easy'),
    Question(
        text: "What was the reason behind the Sega Saturn's failure?",
        choices: ['A. Priced higher compared to the PlayStation', 'B. Overcomplicated Hardware', 'C. Lack 3rd Party Support', 'D. Bad Launch Timing', 'E. All of the above'],
        correctChoiceIndex: 4,
        difficulty: 'medium')
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
      if (_finalScore! >= 8) {
        rank = 'ELITE';
      }
      else if (_finalScore!>= 5) {
        rank = 'Cultured';
      }
      else {
        rank = 'Noob';
      }
      _currentScreen = 'results';
    });
    print('User answered $_userScore questions correctly.');
    print('Final score: ${_finalScore?.toStringAsFixed(1)} / 10');
  }

  void resetApp(){
    setState(() {
      resetQuiz();
      _currentScreen = 'info';
    });
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
    if (_currentScreen == 'results'){
      screen = ResultScreen(
        rank: rank!,
        userName: _userName ?? 'Player',
        userScore: _userScore,
        totalQuestions: _questions.length,
        onPlayAgain: resetApp,
      );
    }
    else if (_currentScreen == 'quiz') {
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
