import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/auth/domain/auth_state.dart';
import 'package:sevenakini_shared/features/auth/domain/user.dart';
import 'package:sevenakini_shared/features/auth/infrastructure/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthStateNotifier extends StateNotifier<AuthState>
    implements AuthRepository {
  AuthStateNotifier(this._supabase)
      : super(
          const AuthState.loading(),
        ) {
    checkAndUpdateState();
  }

  final sp.SupabaseClient _supabase;

  @override
  Future<void> signIn(
    String email,
    String password,
  ) async {
    state = const AuthState.loading();
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        state = const AuthState.error(
          message: 'Failed to sign in',
        );
      }
      state = const AuthState.authenticated();
    } on sp.AuthException catch (e) {
      state = AuthState.error(message: e.message);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await _supabase.auth.signOut();
      state = const AuthState.unauthenticated();
    } on sp.AuthException catch (e) {
      state = AuthState.error(message: e.message);
      rethrow;
    }
  }

  @override
  Future<void> signUp(
    String username,
    String email,
    String password,
    Gender gender,
  ) async {
    state = const AuthState.loading();
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'gender': gender.name,
          'image_url': (gender == Gender.male
                  ? 'https://avatar.iran.liara.run/public/boy?username='
                  : 'https://avatar.iran.liara.run/public/girl?username=') +
              username,
        },
      );

      if (response.user == null) {
        state = const AuthState.error(
          message: 'Failed to sign up',
        );
      }
      //TODO: move this to the backend
      await _supabase.rpc<void>(
        'signup_user',
        params: {
          'id': response.user!.id,
          'username': username,
          'email': email,
          'gender': gender.name,
          'image_url': (gender == Gender.male
                  ? 'https://avatar.iran.liara.run/public/boy?username='
                  : 'https://avatar.iran.liara.run/public/girl?username=') +
              username,
        },
      );
      state = const AuthState.authenticated();
    } on sp.AuthException catch (e) {
      state = AuthState.error(message: e.message);
      rethrow;
    } catch (e) {
      state = AuthState.error(message: e.toString());
      rethrow;
    }
  }

  User get user => User(
        id: _supabase.auth.currentUser!.id,
        username:
            _supabase.auth.currentUser!.userMetadata!['username'] as String,
        email: _supabase.auth.currentUser!.email!,
        gender: Gender.values.firstWhere(
          (element) =>
              element.name ==
              _supabase.auth.currentUser!.userMetadata!['gender'] as String,
        ),
        imageUrl:
            _supabase.auth.currentUser!.userMetadata!['image_url'] as String,
      );

  @override
  void checkAndUpdateState({bool isSignIn = true}) {
    state = _supabase.auth.currentUser != null
        ? const AuthState.authenticated()
        : AuthState.unauthenticated(isSignIn: isSignIn);
  }
}
