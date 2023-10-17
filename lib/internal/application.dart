import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_tz/presentation//pages/home_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo',
        theme: ThemeData(
          primaryColor: Colors.deepOrangeAccent,
          backgroundColor: Colors.white,
          textTheme: GoogleFonts.ptSerifCaptionTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomePage()
    );
  }
}