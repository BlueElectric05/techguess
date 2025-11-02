// lib/screens/login.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techguess/widgets/appbar.dart';
import 'package:techguess/widgets/navbutton.dart';
import 'package:techguess/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _nameController;
  String _userName = '';

  final GlobalKey _nextButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _recordUserName() {
    setState(() {
      _userName = _nameController.text;
    });
    print('User name recorded: $_userName');
    // TODO: Navigate to the next screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'TechGuess',
        backgroundColor: mainColor,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SvgPicture.asset('lib/assets/icons/dark_mode.svg',
                  height: 30, width: 30),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D2D3A),
              Color(0xFF1F1F26),
            ]),
      ),
      child: Column(
        children: [
          const SizedBox(height: 33),
          _buildInfoCard(),
          _buildNavigation(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 33),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: GoogleFonts.angkor(
                color: textColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: ShapeDecoration(
                color: secondColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                ),
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Insert your name here',
                  hintStyle: GoogleFonts.dmSans(
                    color: hintColor,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.dmSans(
                  color: textColor,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Padding(
      padding: const EdgeInsets.all(33.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavButton(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: 'Back',
          ),

          GestureDetector(
            key: _nextButtonKey,
            onTap: _recordUserName,
            child: NavButton(
              onTap: _recordUserName,
              text: 'Next',
            ),
          ),
        ],
      ),
    );
  }
}