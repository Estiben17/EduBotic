import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Importaciones ABSOLUTAS
import 'package:ava_platform/presentation/views/auth/welcome_screen.dart'; // ✅ WelcomeScreen como inicio
import 'package:ava_platform/presentation/viewmodels/auth_viewmodel.dart';
import 'package:ava_platform/presentation/viewmodels/home_viewmodel.dart';
import 'package:ava_platform/data/repositories/auth_repository.dart';
import 'package:ava_platform/data/datasources/remote/firebase_auth_datasource.dart';

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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthDatasource>(
          create: (_) => FirebaseAuthDatasource(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(context.read<FirebaseAuthDatasource>()),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'EduBotic - Plataforma AVA',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(37, 38, 39, 1),
        ),
        home: const WelcomeScreen(), // ✅ SOLO CAMBIA ESTA LÍNEA
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}