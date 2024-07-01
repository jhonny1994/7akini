import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_mobile/providers/chat_notifier_provider.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

final userStreamProvider = StreamProvider<List<User>>((ref) async* {
  final chatNotifier = ref.watch(chatNotifierProvider);
  yield* chatNotifier.getUsers();
});
