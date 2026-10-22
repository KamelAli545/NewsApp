import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/authGate.dart';
import 'package:newsapp/widgets/onBoardingScreen.dart';


class ThirdSplash extends StatelessWidget {
  const ThirdSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: "assets/images/News(3).png",
        title: "Save What Matters to You",
        description:'Bookmark your favorite articles and read them anytime.',
        currentPage: 2,
        totalPages: 3,
        buttonText: "Get Started",
        onPressed: ()=>goToAuthGate(context),
          onPrev: ()=>Navigator.pop(context),
      onSkip: ()=>goToAuthGate(context),
      ),
    );
  }
}
