import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

final userProvider = Provider<User>((ref) {
  return ref.read(authStateNotifierProvider.notifier).user;
});
