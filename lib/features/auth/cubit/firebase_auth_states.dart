part of 'firebase_auth_cubit.dart';

@immutable
abstract class FirebaseAuthState {}

class FirebaseAuthInitial extends FirebaseAuthState {}

class FirebaseAuthLoading extends FirebaseAuthState {}

class FirebaseAuthLoggedIn extends FirebaseAuthState {
  final UserModel user;
  FirebaseAuthLoggedIn(this.user);
}

class FirebaseAuthLoggedOut extends FirebaseAuthState {}

class FirebaseAuthError extends FirebaseAuthState {
  final String messageKey;
  FirebaseAuthError(this.messageKey);
}

// Forgot Password States
class ForgotPasswordLoading extends FirebaseAuthState {}

class ForgotPasswordSuccess extends FirebaseAuthState {}

class ForgotPasswordError extends FirebaseAuthState {
  final String messageKey;
  ForgotPasswordError(this.messageKey);
}

// Profile Update States
class ProfileUpdateLoading extends FirebaseAuthState {}

class ProfileUpdateSuccess extends FirebaseAuthState {}

class ProfileUpdateError extends FirebaseAuthState {
  final String messageKey;
  ProfileUpdateError(this.messageKey);
}
