import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp(
      title: 'EduBotic - Plataforma AVA',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AuthCheckScreen(),
    );
  }
}

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  String _firestoreStatus = 'Verificando...';
  String _authStatus = 'Verificando...';
  bool _testing = false;

  Future<void> _testFirestoreConnection() async {
    setState(() {
      _testing = true;
      _firestoreStatus = 'Probando conexión...';
    });

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      
      // Escribir documento de prueba
      await firestore.collection('connection_tests').doc('flutter_test').set({
        'timestamp': FieldValue.serverTimestamp(),
        'app': 'EduBotic',
        'status': 'connected'
      });
      
      // Leer el documento
      DocumentSnapshot snapshot = await firestore.collection('connection_tests').doc('flutter_test').get();
      
      if (snapshot.exists) {
        setState(() {
          _firestoreStatus = '✅ CONEXIÓN EXITOSA';
        });
        print('Firestore: Conexión exitosa - ${snapshot.data()}');
      } else {
        setState(() {
          _firestoreStatus = '❌ Documento no encontrado';
        });
      }
      
    } catch (e) {
      setState(() {
        _firestoreStatus = '❌ ERROR: $e';
      });
      print('Firestore Error: $e');
    }
  }

  Future<void> _testAuthConnection() async {
    setState(() {
      _authStatus = 'Probando conexión...';
    });

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      
      // Probar obtener usuario actual (puede ser null, eso es normal)
      User? currentUser = auth.currentUser;
      
      setState(() {
        _authStatus = '✅ CONEXIÓN EXITOA - Usuario: ${currentUser?.email ?? "No logueado"}';
      });
      print('Auth: Conexión exitosa - User: $currentUser');
      
    } catch (e) {
      setState(() {
        _authStatus = '❌ ERROR: $e';
      });
      print('Auth Error: $e');
    }
  }

  Future<void> _testAllConnections() async {
    await _testFirestoreConnection();
    await _testAuthConnection();
    setState(() {
      _testing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Probar conexiones automáticamente al iniciar
    _testAllConnections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación Firebase'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'Estado de Conexiones Firebase',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // Estado de Firestore
              _buildStatusCard(
                'Cloud Firestore',
                _firestoreStatus,
                Icons.cloud,
              ),
              const SizedBox(height: 20),
              
              // Estado de Authentication
              _buildStatusCard(
                'Authentication',
                _authStatus,
                Icons.security,
              ),
              const SizedBox(height: 30),
              
              if (_testing)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _testAllConnections,
                  child: const Text('Volver a Probar Conexiones'),
                ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navegar a login después
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Continuar a Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String status, IconData icon) {
    Color color = status.contains('✅') ? Colors.green : 
                 status.contains('❌') ? Colors.red : Colors.orange;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}