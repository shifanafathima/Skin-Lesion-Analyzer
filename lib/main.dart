import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'utils/colors.dart';
import 'widgets/skin_card.dart';

void main() {
  runApp(const MyApp());
}

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
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

  final List<Widget> _screens = [
    const HomeScreen(),
    const CameraScreen(),
    const AnalysisScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.secondary,
        height: 65,
        items: const [
          Icon(Icons.home_rounded, size: 30, color: Colors.white),
          Icon(Icons.camera_alt_rounded, size: 30, color: Colors.white),
          Icon(Icons.analytics_rounded, size: 30, color: Colors.white),
          Icon(Icons.person_rounded, size: 30, color: Colors.white),
        ],
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// =============== HOME SCREEN ===============
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 30),
            _buildSkinAnalysis(),
            const SizedBox(height: 30),
            _buildSkinHealthChart(),
            const SizedBox(height: 30),
            _buildRecommendations(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 25,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Beautiful! 👑',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your skin health improved by 15% this month!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.trending_up_rounded, color: Colors.yellow, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Score: 88/100',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.face_retouching_natural_rounded,
            size: 100,
            color: Colors.white.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildSkinAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skin Analysis',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.3,
          children: [
            SkinCard(
              title: 'Acne Detection',
              value: '92%',
              icon: Icons.sentiment_satisfied_rounded,
              color: AppColors.success,
              progress: 0.92,
            ),
            SkinCard(
              title: 'Wrinkles',
              value: '15%',
              icon: Icons.auto_awesome_rounded,
              color: AppColors.warning,
              progress: 0.15,
            ),
            SkinCard(
              title: 'Dark Spots',
              value: '30%',
              icon: Icons.brightness_medium_rounded,
              color: AppColors.info,
              progress: 0.30,
            ),
            SkinCard(
              title: 'Pore Size',
              value: '45%',
              icon: Icons.circle_rounded,
              color: AppColors.primary,
              progress: 0.45,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkinHealthChart() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Simple bar chart with containers
          Column(
            children: [
              _buildChartBar('Mon', 70, AppColors.primary),
              _buildChartBar('Tue', 75, AppColors.primary),
              _buildChartBar('Wed', 80, AppColors.primary),
              _buildChartBar('Thu', 78, AppColors.primary),
              _buildChartBar('Fri', 85, AppColors.primary),
              _buildChartBar('Sat', 90, AppColors.primary),
              _buildChartBar('Sun', 92, AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String day, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(day),
          ),
          Expanded(
            child: Container(
              height: 20,
              width: value.toDouble() * 2,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '$value%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    final recommendations = [
      {'icon': Icons.local_drink_rounded, 'title': 'Hydration', 'desc': 'Drink 3L water daily'},
      {'icon': Icons.nightlight_rounded, 'title': 'Sleep', 'desc': '8 hours nightly'},
      {'icon': Icons.spa_rounded, 'title': 'Moisturize', 'desc': 'AM & PM routine'},
      {'icon': Icons.wb_sunny_rounded, 'title': 'Sunscreen', 'desc': 'SPF 50+ essential'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Recommendations',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: index == recommendations.length - 1 ? 0 : 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        recommendations[index]['icon'] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      recommendations[index]['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      recommendations[index]['desc'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Start Full Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============== CAMERA SCREEN ===============
class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Scanner'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: const Icon(
                Icons.face_retouching_natural_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Position face within frame',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// =============== ANALYSIS SCREEN ===============
class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Results'),
      ),
      body: const Center(
        child: Text('Analysis Screen'),
      ),
    );
  }
}

// =============== PROFILE SCREEN ===============
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}