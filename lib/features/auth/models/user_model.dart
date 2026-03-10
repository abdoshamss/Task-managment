/// User model for TaskFlow (Firebase Auth).
class UserModel {
  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid as String,
      email: user.email as String? ?? '',
      displayName: user.displayName as String?,
      photoUrl: user.photoURL as String?,
    );
  }
}
