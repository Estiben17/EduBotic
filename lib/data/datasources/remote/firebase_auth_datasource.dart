import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '850963688325-l4665odr4j1ft9jptfruomc9rp02vovs.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  // ✅ IMPLEMENTAR SIGN IN WITH GOOGLE
  Future<UserModel?> signInWithGoogle() async {
    try {
      print('Iniciando autenticación con Google...');
      
      // Iniciar el flujo de autenticación de Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print('Usuario canceló el login con Google');
        return null; // Usuario canceló
      }

      print('Usuario de Google obtenido: ${googleUser.email}');
      
      // Obtener los detalles de autenticación
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      print('Token de Google obtenido');

      // Crear una credencial para Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Credencial creada, iniciando sesión en Firebase...');

      // Iniciar sesión en Firebase con la credencial
      final UserCredential userCredential = 
          await _auth.signInWithCredential(credential);

      print('Sesión iniciada en Firebase: ${userCredential.user?.email}');

      // Verificar si el usuario ya existe en Firestore, si no, crearlo
      UserModel? userModel = await _getUserModel(userCredential.user!);
      
      if (userModel == null) {
        // Crear nuevo usuario en Firestore
        print('Creando nuevo usuario en Firestore...');
        userModel = await _createUserFromGoogle(
          userCredential.user!, 
          googleUser
        );
      }

      return userModel;
    } catch (e) {
      print("Error en signInWithGoogle: $e");
      return null;
    }
  }

  // ✅ CORREGIR MÉTODO PARA CREAR USUARIO DESDE GOOGLE
  Future<UserModel> _createUserFromGoogle(User user, GoogleSignInAccount googleUser) async {
    try {
      // ✅ USAR EL NUEVO CONSTRUCTOR CON TODOS LOS CAMPOS
      final userModel = UserModel(
        uid: user.uid,
        email: user.email!,
        name: googleUser.displayName ?? user.displayName ?? 'Usuario',
        role: 'student',
        photoUrl: user.photoURL ?? googleUser.photoUrl, // ✅ AÑADIR photoUrl
        createdAt: DateTime.now(),
        profileImage: googleUser.photoUrl ?? user.photoURL,
      );

      // Guardar en Firestore
      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

      return userModel;
    } catch (e) {
      print("Error creando usuario desde Google: $e");
      // Si falla Firestore, devolver modelo básico
      return UserModel.fromFirebaseUser(user);
    }
  }

  // Login con email y contraseña
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return await _getUserModel(result.user!);
    } catch (e) {
      print("Error en login: $e");
      return null;
    }
  }

  // Registrar nuevo usuario
  Future<UserModel?> registerWithEmail(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // ✅ ACTUALIZAR PARA USAR EL NUEVO UserModel
      final userModel = UserModel(
        uid: result.user!.uid,
        email: email,
        name: name,
        role: 'student',
        photoUrl: null,
        createdAt: DateTime.now(),
        profileImage: null,
      );
      
      // Crear documento del usuario en Firestore
      await _firestore.collection('users').doc(result.user!.uid).set(userModel.toMap());
      
      return userModel;
    } catch (e) {
      print("Error en registro: $e");
      return null;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Convertir User de Firebase a nuestro UserModel
  Future<UserModel?> _getUserModel(User user) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      // Si no existe en Firestore, crear uno básico desde Firebase Auth
      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      print("Error getting user model: $e");
      return null;
    }
  }
}