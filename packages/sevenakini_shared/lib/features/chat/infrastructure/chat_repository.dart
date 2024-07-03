import 'package:sevenakini_shared/sevenakini_shared.dart';

abstract class ChatRepository {
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String content,
    String chatId,
  );
  Future<String> getChatId(
    String senderId,
    String receiverId,
  );

  Stream<List<Message>> getChat(String chatId);

  Stream<List<User>> getUsers();
}
