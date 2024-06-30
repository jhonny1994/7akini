import 'package:sevenakini_shared/features/chat/domain/message.dart';
import 'package:sevenakini_shared/features/core/domain/app_response.dart';

abstract class ChatRepository {
  Future<AppResponse> addMessage(Message message);
  Stream<List<Message>> getChatMessages(String chatId);
}
