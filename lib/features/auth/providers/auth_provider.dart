import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

/// Auth state and actions using Firebase Auth.
class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  AuthProvider() {
    _listenAuthState();
  }

  void _listenAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _currentUser = UserModel.fromFirebaseUser(user);
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  /// Maps Firebase Auth exception to a localization key or message.
  String _mapAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'emailNotFound';
        case 'wrong-password':
          return 'wrongPassword';
        case 'email-already-in-use':
          return 'emailAlreadyInUse';
        case 'weak-password':
          return 'passwordTooWeak';
        case 'network-request-failed':
          return 'checkInternet';
        case 'permission-denied':
          return 'permissionDenied';
        default:
          return e.message ?? 'unknownError';
      }
    }
    return 'unknownError';
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapAuthError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String fullName, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (cred.user != null && fullName.trim().isNotEmpty) {
        await cred.user!.updateDisplayName(fullName.trim());
      }
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapAuthError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Sync current user from Firebase (e.g. after display name update).
  void refreshUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _currentUser = UserModel.fromFirebaseUser(user);
    } else {
      _currentUser = null;
    }
    notifyListeners();
  }
}
