import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/authGate.dart';
import 'package:newsapp/screens/thirdSplash.dart';
import 'package:newsapp/widgets/onBoardingScreen.dart';

class SecondSplash extends StatelessWidget {
  const SecondSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: "assets/images/News(2).png",
        title: "Explore News You Care About",
        description:
        'Search any topic and discover stories from around the world.',
        currentPage: 1,
        totalPages: 3,
        buttonText: "Next",
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ThirdSplash())),
        onPrev: ()=>Navigator.pop(context),
        onSkip: ()=>goToAuthGate(context),
      ),
    );
  }
}
