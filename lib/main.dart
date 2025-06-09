import 'package:flutter/material.dart';
import 'package:website_portfolio/home_page.dart';
import 'package:website_portfolio/widgets/navbar.dart';
import 'package:website_portfolio/widgets/hero_section.dart';
import 'package:website_portfolio/theme/gradient_theme.dart'; // import the theme

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        extensions: <ThemeExtension<dynamic>>[
          GradientTheme(
            background: const LinearGradient(
              colors: [
                Color(0xFFfafcfb),
                Color(0xFF45a99d),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ],
      ),
      home: const HomePage(),
    );
  }
}
