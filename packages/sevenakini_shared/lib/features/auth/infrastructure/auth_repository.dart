import 'package:sevenakini_shared/sevenakini_shared.dart';

abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn(
    String email,
    String password,
  );

  Future<void> addUserInfo({
    required String fullName,
    required String username,
    required Gender gender,
  });

  Future<void> signOut();

  Future<void> checkUserInfo();

  void checkAndUpdateState();
}
