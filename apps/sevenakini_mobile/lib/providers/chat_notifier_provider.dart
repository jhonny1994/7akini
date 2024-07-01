import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/application/chat_notifier.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

final chatNotifierProvider = Provider<ChatNotifier>((ref) {
  final supabase = ref.read(supabaseProvider);
  final user = ref.read(authStateNotifierProvider.notifier).user;
  return ChatNotifier(supabase, user);
});
