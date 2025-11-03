abstract class IAuthRepository {
  Future<dynamic> signInWithEmail(String email, String password);
  Future<dynamic> registerWithEmail(String email, String password, String name);
  Future<dynamic> signInWithGoogle();
  Future<bool> signOut();
  Future<dynamic> getCurrentUser();
  Future<bool> resetPassword(String email);
  Future<dynamic> updateProfile(String name, String? photoUrl);
}