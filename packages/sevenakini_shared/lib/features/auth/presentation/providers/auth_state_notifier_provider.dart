import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/auth/application/auth_state_notifier.dart';
import 'package:sevenakini_shared/features/auth/domain/auth_state.dart';
import 'package:sevenakini_shared/features/core/providers/supabase_provider.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final supabase = ref.read(supabaseProvider);
  return AuthStateNotifier(supabase);
});
