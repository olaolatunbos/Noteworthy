typedef UserID = String;

/// Simple class representing the user UID and email.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.username,
  });
  final UserID uid;
  final String? email;
  final String? username;

  // * Here we override methods from [Object] directly rather than using
  // * [Equatable], since this class will be subclassed or implemented
  // * by other classes.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.email == email &&
        other.username == username;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  @override
  String toString() => 'AppUser(uid: $uid, email: $email, username: $username)';

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };
}
