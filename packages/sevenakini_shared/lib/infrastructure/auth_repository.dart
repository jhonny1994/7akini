import 'package:sevenakini_shared/domain/user.dart';

abstract class AuthRepository {
  Future<void> signUp(
    String username,
    String email,
    String password,
    Gender gender,
  );

  Future<void> signIn(
    String email,
    String password,
  );

  Future<void> signOut();
}
