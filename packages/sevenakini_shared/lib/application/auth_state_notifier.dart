import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/domain/auth_state.dart';
import 'package:sevenakini_shared/domain/user.dart';
import 'package:sevenakini_shared/infrastructure/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthStateNotifier extends StateNotifier<AuthState>
    implements AuthRepository {
  AuthStateNotifier(this._supabase) : super(const AuthState.loading());

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
        state = const AuthState.unauthenticated(
          message: 'Failed to sign in',
        );
      }
      state = const AuthState.authenticated();
    } on sp.AuthException catch (e) {
      state = AuthState.unauthenticated(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    state = const AuthState.loading();
    await _supabase.auth.signOut();
    state = const AuthState.unauthenticated();
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
        },
      );
      if (response.user == null) {
        state = const AuthState.unauthenticated(
          message: 'Failed to sign up',
        );
      }
      print(response.user);
      state = const AuthState.authenticated();
    } on sp.AuthException catch (e) {
      state = AuthState.unauthenticated(message: e.message);
    }
  }

  sp.User get user => _supabase.auth.currentUser!;
}
