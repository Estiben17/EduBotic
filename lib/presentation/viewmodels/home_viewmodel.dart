import 'package:flutter/material.dart';
import 'package:ava_platform/domain/entities/user_entity.dart';

class HomeViewModel with ChangeNotifier {
  UserEntity? _currentUser;
  bool _isLoading = false;

  HomeViewModel();

  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Por ahora no cargamos usuario, luego lo implementas con Firebase
      _currentUser = null;
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _currentUser = null;
    } catch (e) {
      print("Error signing out: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUserData() {
    _currentUser = null;
    notifyListeners();
  }
}