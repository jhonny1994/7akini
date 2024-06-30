import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sevenakini_shared/domain/app_response.dart';
import 'package:sevenakini_shared/domain/message.dart';
import 'package:sevenakini_shared/infrastructure/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class ChatStateNotifier extends StateNotifier<List<Message>>
    implements ChatRepository {
  ChatStateNotifier(this._supabase) : super([]);
  final sp.SupabaseClient _supabase;

  @override
  @override
  Future<AppResponse> sendMessage(
    Message message,
    String contactId,
  ) async {
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
  Stream<List<Message>> getMessages(String userId, String contactId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}
