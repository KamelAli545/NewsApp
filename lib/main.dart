import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/auth_cubit.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:newsapp/firebase_options.dart';
import 'package:newsapp/screens/splashScreen.dart';
import 'package:newsapp/widgets/newsTab.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsCubit()..loadCategory(NewsCategory.general),
        ),        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );  }
}