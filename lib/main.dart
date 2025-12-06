import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'utils/colors.dart';
import 'widgets/camera_screen.dart';
import 'widgets/profile_screen.dart';
import 'home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Skin Analyzer Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.light,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Only screens that do not require runtime parameters
  final List<Widget> _screens = [
    const HomeScreen(),
    CameraScreen(), // CameraScreen handles navigation to PredictionScreen
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: AppColors.primary,
          buttonBackgroundColor: AppColors.secondary,
          height: 65,
          items: const [
            Icon(Icons.home_rounded, size: 30, color: Colors.white),
            Icon(Icons.camera_alt_rounded, size: 30, color: Colors.white),
            Icon(Icons.person_rounded, size: 30, color: Colors.white),
          ],
          index: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}