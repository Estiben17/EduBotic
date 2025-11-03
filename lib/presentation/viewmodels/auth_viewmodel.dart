import 'package:flutter/foundation.dart';
import '../../../domain/repositories/i_auth_repository.dart';
import '../../../domain/entities/user_entity.dart';

class AuthViewModel with ChangeNotifier {
  final IAuthRepository _authRepository;

  AuthViewModel({required IAuthRepository authRepository}) 
      : _authRepository = authRepository;

  // ===========================================================================
  // ESTADO
  // ===========================================================================
  bool _isLoading = false;
  String? _errorMessage;
  UserEntity? _currentUser;

  // ===========================================================================
  // GETTERS
  // ===========================================================================
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserEntity? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  // ===========================================================================
  // MÉTODOS DE AUTENTICACIÓN
  // ===========================================================================
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (email.isEmpty || password.isEmpty) {
        _errorMessage = 'Por favor completa todos los campos';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = await _authRepository.signInWithEmail(email, password);
      
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Error en el login. Verifica tus credenciales.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error en el login: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        _errorMessage = 'Por favor completa todos los campos';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (password.length < 6) {
        _errorMessage = 'La contraseña debe tener al menos 6 caracteres';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = await _authRepository.registerWithEmail(email, password, name);
      
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Error en el registro. Intenta nuevamente.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error en el registro: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ===========================================================================
  // MÉTODOS ADICIONALES (puedes implementarlos después)
  // ===========================================================================
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authRepository.signInWithGoogle();
      
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Error en el login con Google.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error en el login con Google: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _authRepository.signOut();
      
      if (success) {
        _currentUser = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Error al cerrar sesión';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al cerrar sesión: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ===========================================================================
  // MÉTODOS DE LIMPIEZA
  // ===========================================================================
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}