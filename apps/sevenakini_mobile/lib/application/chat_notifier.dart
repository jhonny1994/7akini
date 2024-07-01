import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/sevenakini_shared.dart';

class ChatNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  ChatNotifier() : super(const AsyncValue.loading());
}
