import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/application/auth_state_notifier.dart';
import 'package:sevenakini_shared/domain/auth_state.dart';
import 'package:sevenakini_shared/presentation/providers/supabase_provider.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final supabase = ref.read(supabaseProvider);
  return AuthStateNotifier(supabase);
});
