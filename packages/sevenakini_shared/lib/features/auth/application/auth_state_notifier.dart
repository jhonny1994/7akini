import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/auth/domain/auth_state.dart';
import 'package:sevenakini_shared/features/auth/domain/user.dart';
import 'package:sevenakini_shared/features/auth/infrastructure/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class AuthStateNotifier extends StateNotifier<AuthState>
    implements AuthRepository {
  AuthStateNotifier(this._supabase) : super(const AuthState.loading()) {
    checkAndUpdateState();
  }
  final sp.SupabaseClient _supabase;

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
        fullName:
            _supabase.auth.currentUser!.userMetadata!['full_name'] as String,
      );

  @override
  Future<void> addUserInfo({
    required String fullName,
    required String username,
    required Gender gender,
  }) async {
    state = const AuthState.loading();
    final imageUrl = (gender == Gender.male
            ? 'https://avatar.iran.liara.run/public/boy?username='
            : 'https://avatar.iran.liara.run/public/girl?username=') +
        username;
    try {
      await _supabase.auth.updateUser(
        sp.UserAttributes(
          data: {
            'username': username,
            'full_name': fullName,
            'gender': gender.name,
            'image_url': imageUrl,
          },
        ),
      );

      await _supabase.rpc<void>(
        'create_member',
        params: {
          'id': _supabase.auth.currentUser!.id,
          'username': username,
          'full_name': fullName,
          'email': _supabase.auth.currentUser!.email,
          'gender': gender.name,
          'image_url': imageUrl,
        },
      );
      await checkAndUpdateState();
    } on sp.AuthException catch (e) {
      state = AuthState.error(message: e.message);
      rethrow;
    } catch (e) {
      state = AuthState.error(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> checkAndUpdateState({bool isSignIn = true}) async {
    final isUserInfoAvailable = await checkUserInfo();
    state = _supabase.auth.currentUser != null
        ? isUserInfoAvailable
            ? const AuthState.authenticated()
            : const AuthState.userInfo()
        : AuthState.unauthenticated(isSignIn: isSignIn);
  }

  @override
  Future<bool> checkUserInfo() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await _supabase
            .from('members')
            .select()
            .eq('id', user.id)
            .maybeSingle();
        return response != null;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

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
      await checkAndUpdateState();
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
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        state = const AuthState.error(
          message: 'Failed to sign up',
        );
      }

      await checkAndUpdateState();
    } on sp.AuthException catch (e) {
      state = AuthState.error(message: e.message);
      rethrow;
    }
  }
}
