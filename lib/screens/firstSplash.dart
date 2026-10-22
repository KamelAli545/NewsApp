import 'package:flutter/material.dart';
import 'package:newsapp/screens/authGate.dart';
import 'package:newsapp/screens/secondSplash.dart';
import 'package:newsapp/widgets/onBoardingScreen.dart';

class FirstSplash extends StatelessWidget {
  const FirstSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: 'assets/images/News(1).png',
        title: 'Stay Updated with Latest News',
        description:
        'Get the latest headlines from trusted sources all in one place.',
        currentPage: 0,
        totalPages: 3,
        buttonText: 'Next',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  SecondSplash()),
        ),
        onPrev: null,
        onSkip: () => goToAuthGate(context),
      ),
    );
  }
}