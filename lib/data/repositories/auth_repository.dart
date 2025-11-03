import '../datasources/remote/firebase_auth_datasource.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuthDatasource _datasource;

  AuthRepository(this._datasource);

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    final user = await _datasource.signInWithEmail(email, password);
    if (user != null) {
      return UserEntity(
        id: user.uid,
        email: user.email,
        name: user.name,
        photoUrl: user.photoUrl,
      );
    }
    return null;
  }

  @override
  Future<UserEntity?> registerWithEmail(String email, String password, String name) async {
    final user = await _datasource.registerWithEmail(email, password, name);
    if (user != null) {
      return UserEntity(
        id: user.uid,
        email: user.email,
        name: user.name,
        photoUrl: user.photoUrl,
      );
    }
    return null;
  }

  // ✅ CORREGIR ESTE MÉTODO - ELIMINAR UnimplementedError
  @override
  Future<UserEntity?> signInWithGoogle() async {
    final user = await _datasource.signInWithGoogle();
    if (user != null) {
      return UserEntity(
        id: user.uid,
        email: user.email,
        name: user.name,
        photoUrl: user.photoUrl,
      );
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    await _datasource.signOut();
    return true;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // TODO: Implementar usando el datasource
    throw UnimplementedError('getCurrentUser not implemented yet');
  }

  @override
  Future<bool> resetPassword(String email) async {
    // TODO: Implementar usando el datasource
    throw UnimplementedError('resetPassword not implemented yet');
  }

  @override
  Future<UserEntity?> updateProfile(String name, String? photoUrl) async {
    // TODO: Implementar usando el datasource
    throw UnimplementedError('updateProfile not implemented yet');
  }
}