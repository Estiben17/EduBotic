class UserEntity {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? role; // ✅ AÑADIR SI LO NECESITAS
  final DateTime? createdAt; // ✅ AÑADIR SI LO NECESITAS

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.role,
    this.createdAt,
  });

  // Métodos adicionales si los necesitas
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }
}