import 'package:sevenakini_shared/domain/app_response.dart';
import 'package:sevenakini_shared/domain/message.dart';

abstract class ChatRepository {
  Future<AppResponse> addMessage(Message message);
  Stream<List<Message>> getChatMessages(String chatId);
}
