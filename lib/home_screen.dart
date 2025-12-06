import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greetings = [
      'Glow On, Gorgeous! ✨',
      'Your Skin Deserves Love Today ❤️',
      'Hello, Radiant You! 🌿',
      'Skin Strong, Mind Strong 💪',
      'Shine Bright, Naturally 🌟',
      'Your Glow is Showing! 🌸',
      'Healthy Skin, Happy You 😄',
    ];

    final greeting = (greetings..shuffle()).first;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
      ),
      body: SafeArea(
        top: true,
        bottom: false, // Let the BottomNavigationBar handle bottom space
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Container(
                padding: const EdgeInsets.all(20),
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
                            greeting,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Take care of your skin and shine every day!',
                            style: TextStyle(color: Colors.white70, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.face_retouching_natural_rounded,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Daily Recommendations
              const Text(
                'Daily Recommendations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildRecommendationCard(Icons.local_drink_rounded, 'Hydration', 'Drink 3L water'),
                    _buildRecommendationCard(Icons.nightlight_rounded, 'Sleep', '8 hours nightly'),
                    _buildRecommendationCard(Icons.spa_rounded, 'Moisturize', 'AM & PM routine'),
                    _buildRecommendationCard(Icons.wb_sunny_rounded, 'Sunscreen', 'SPF 50+ essential', isLast: true),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Affirmation of the Day
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Affirmation of the Day',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '“Healthy skin, healthy confidence. Shine from within!”',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Dermatologist Cards in Salem
              const Text(
                'Top Dermatologists in Salem',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildDermatologistCard('Dr. Alice Smith', 'Salem', '5 yrs exp'),
                    _buildDermatologistCard('Dr. John Doe', 'Salem', '8 yrs exp'),
                    _buildDermatologistCard('Dr. Emily Clark', 'Salem', '6 yrs exp'),
                  ],
                ),
              ),

              const SizedBox(height: 20), // bottom spacing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(IconData icon, String title, String desc, {bool isLast = false}) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: isLast ? 0 : 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              desc,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDermatologistCard(String name, String location, String experience) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(location, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(experience, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}