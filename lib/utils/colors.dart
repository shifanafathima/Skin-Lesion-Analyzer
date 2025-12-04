import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF4A44C6);
  static const Color accent = Color(0xFFFF6584);
  static const Color light = Color(0xFFF8F9FA);
  
  // Skin Type Colors
  static const Color normal = Color(0xFFFFF3E0);
  static const Color oily = Color(0xFFE8F5E9);
  static const Color dry = Color(0xFFE3F2FD);
  static const Color combination = Color(0xFFF3E5F5);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF4A44C6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6584), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}