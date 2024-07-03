import 'package:sevenakini_shared/sevenakini_shared.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class ChatNotifier implements ChatRepository {
  ChatNotifier(
    this._supabase,
    this._user,
  );

  final sp.SupabaseClient _supabase;
  final User _user;

  @override
  Stream<List<Message>> getChat(String chatId) => _supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .eq('chat_id', chatId)
      .map(
        (e) => e.map(Message.fromJson).toList(),
      );

  @override
  Future<String> getChatId(
    String senderId,
    String receiverId,
  ) async {
    try {
      final response = await _supabase.rpc<String>(
        'find_or_create_chat',
        params: {
          'sender_id_in': senderId,
          'receiver_id_in': receiverId,
        },
      );
      return response;
    } on sp.AuthException {
      rethrow;
    }
  }

  @override
  Stream<List<User>> getUsers() => _supabase
      .from('members')
      .stream(primaryKey: ['id'])
      .neq('id', _user.id)
      .map((e) => e.map(User.fromJson).toList());

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String content,
    String chatId,
  ) async {
    try {
      final message = Message(
        senderId: senderId,
        receiverId: receiverId,
        chatId: chatId,
        content: content,
        createdAt: DateTime.now(),
      );
      await _supabase.from('messages').insert(message.toJson());
    } on sp.AuthException {
      rethrow;
    }
  }
}
