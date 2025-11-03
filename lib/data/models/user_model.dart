import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // ✅ AÑADIR PARA GOOGLE

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final String? photoUrl;
  final DateTime? createdAt;
  final String? profileImage; 

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.photoUrl,
    this.createdAt,
    this.profileImage,
  });

  // ✅ MÉTODO FROM MAP PARA FIRESTORE
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? 'student',
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      profileImage: map['profileImage'],
    );
  }

  // ✅ MÉTODO TO MAP PARA FIRESTORE
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
      'photoUrl': photoUrl,
      'profileImage': profileImage,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  // ✅ MÉTODO FROM FIREBASE USER (para compatibilidad)
  factory UserModel.fromFirebaseUser(User user, {String name = '', String role = 'student'}) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? name,
      role: role,
      photoUrl: user.photoURL,
      profileImage: user.photoURL, // ✅ USAR photoURL COMO profileImage TAMBIÉN
      createdAt: DateTime.now(),
    );
  }

  // ✅ NUEVO MÉTODO: FROM GOOGLE USER (lo que necesitas)
  factory UserModel.fromGoogleUser(User user, GoogleSignInAccount googleUser) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? googleUser.email,
      name: googleUser.displayName ?? user.displayName ?? 'Usuario',
      role: 'student',
      photoUrl: user.photoURL ?? googleUser.photoUrl,
      profileImage: googleUser.photoUrl ?? user.photoURL, // ✅ PRIORIZAR FOTO DE GOOGLE
      createdAt: DateTime.now(),
    );
  }

  // ✅ MÉTODO PARA CREAR USUARIO BÁSICO (alternativo)
  factory UserModel.createBasic({
    required String uid,
    required String email,
    required String name,
    String role = 'student',
    String? photoUrl,
    String? profileImage,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      name: name,
      role: role,
      photoUrl: photoUrl,
      profileImage: profileImage,
      createdAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, role: $role)';
  }

  // ✅ MÉTODO COPYWITH PARA ACTUALIZACIONES (opcional pero útil)
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? role,
    String? photoUrl,
    DateTime? createdAt,
    String? profileImage,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}