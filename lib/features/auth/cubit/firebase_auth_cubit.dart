import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../../../core/data_source/hive_service.dart';
import '../../../core/utils/general_constants.dart';

part 'firebase_auth_states.dart';

/// Firebase Auth Cubit for TaskFlow (login, register, logout).
class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  FirebaseAuthCubit() : super(FirebaseAuthInitial()) {
    _listenAuthState();
  }

  static FirebaseAuthCubit get(context) => context.read<FirebaseAuthCubit>();

  void _listenAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final userModel = UserModel.fromFirebaseUser(user);
        await HiveService.putJson(
          GeneralConstants.appBoxName,
          GeneralConstants.userKey,
          userModel.toJson(),
        );
        emit(FirebaseAuthLoggedIn(userModel));
      } else {
        await HiveService.remove(
          GeneralConstants.appBoxName,
          GeneralConstants.userKey,
        );
        emit(FirebaseAuthLoggedOut());
      }
    });
  }

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
    emit(FirebaseAuthLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return true;
    } catch (e) {
      emit(FirebaseAuthError(_mapAuthError(e)));
      return false;
    }
  }

  Future<bool> register(String fullName, String email, String password) async {
    emit(FirebaseAuthLoading());
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (cred.user != null && fullName.trim().isNotEmpty) {
        await cred.user!.updateDisplayName(fullName.trim());
      }
      return true;
    } catch (e) {
      emit(FirebaseAuthError(_mapAuthError(e)));
      return false;
    }
  }

  Future<void> logout() async {
    emit(FirebaseAuthLoading());
    await FirebaseAuth.instance.signOut();
    emit(FirebaseAuthLoggedOut());
  }

  Future<bool> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      emit(ForgotPasswordSuccess());
      return true;
    } catch (e) {
      emit(ForgotPasswordError(_mapAuthError(e)));
      return false;
    }
  }

  Future<bool> updateProfile({String? displayName}) async {
    emit(ProfileUpdateLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(ProfileUpdateError('unknownError'));
        return false;
      }
      if (displayName != null) {
        await user.updateDisplayName(displayName.trim());
      }
      await user.reload();
      final updated = FirebaseAuth.instance.currentUser;
      if (updated != null) {
        emit(FirebaseAuthLoggedIn(UserModel.fromFirebaseUser(updated)));
      }
      emit(ProfileUpdateSuccess());
      return true;
    } catch (e) {
      emit(ProfileUpdateError(_mapAuthError(e)));
      return false;
    }
  }

  UserModel? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return UserModel.fromFirebaseUser(user);
    final state = this.state;
    if (state is FirebaseAuthLoggedIn) return state.user;
    return null;
  }
}
