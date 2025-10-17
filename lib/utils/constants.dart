import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'EduBotic AVA';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Plataforma Educativa en Robótica';
  
  // Colores del tema
  static const primaryColor = 0xFF4CAF50;
  static const secondaryColor = 0xFF2196F3;
  static const accentColor = 0xFFFFC107;
  
  // Nuevos colores para WelcomeScreen y otras pantallas
  static const Color darkBackground = Color.fromRGBO(37, 38, 39, 1);
  static const Color darkContainer = Color.fromRGBO(50, 51, 52, 1);
  static const Color welcomePrimary = Color.fromRGBO(27, 120, 160, 1);
  static const Color welcomeWhite = Color.fromRGBO(255, 255, 255, 1);
  
  // Colecciones de Firestore
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses'; 
  static const String lessonsCollection = 'lessons';
  static const String progressCollection = 'progress';
}