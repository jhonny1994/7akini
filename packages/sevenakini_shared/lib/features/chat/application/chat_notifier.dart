import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/features/chat/domain/message.dart';
import 'package:sevenakini_shared/features/chat/infrastructure/chat_repository.dart';
import 'package:sevenakini_shared/features/core/domain/app_response.dart';

import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class ChatStateNotifier extends StateNotifier<List<Message>>
    implements ChatRepository {
  ChatStateNotifier(this._supabase) : super([]);
  final sp.SupabaseClient _supabase;

  // Helper method to find existing chat

  @override
  Future<AppResponse> addMessage(Message message) async {
    try {
      await _supabase.from('messages').insert(
            message.toJson(),
          );
      state = [...state, message];
      return const AppResponse.success();
    } on sp.AuthException catch (e) {
      return AppResponse.failure(e.message);
    }
  }

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    try {
      return _supabase
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('chat_id', chatId)
          .order('created_at', ascending: true)
          .map(
            (event) => event.map(Message.fromJson).toList(),
          );
    } on sp.AuthException catch (e) {
      return Stream.error(e.message);
    }
  }
}
