import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

final messagesStreamProvider =
    StreamProvider.family<List<Message>, String>((ref, chatId) async* {
  final chatNotifier = ref.watch(chatNotifierProvider);
  yield* chatNotifier.getChat(chatId);
});
