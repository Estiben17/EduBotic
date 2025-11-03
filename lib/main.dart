import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/views/auth/welcome_screen.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'data/repositories/auth_repository.dart';
import 'data/datasources/remote/firebase_auth_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC_5OzuPzVM1unKaUzZN3obe4MWW6TgHaI",
      authDomain: "edubotic-4a675.firebaseapp.com",
      projectId: "edubotic-4a675",
      storageBucket: "edubotic-4a675.firebasestorage.app",
      messagingSenderId: "850963688325",
      appId: "1:850963688325:web:be94723cb3d226ec0f72ec",
      measurementId: "G-PGRRZ6B89M"
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(
        authRepository: AuthRepository(FirebaseAuthDatasource()), // ✅ Proporcionar el datasource
      ),
      child: MaterialApp(
        title: 'EduBotic - Plataforma AVA',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}