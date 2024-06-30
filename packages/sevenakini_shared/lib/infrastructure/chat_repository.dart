import 'package:sevenakini_shared/domain/app_response.dart';
import 'package:sevenakini_shared/domain/message.dart';

abstract class ChatRepository {
  Future<AppResponse> sendMessage(
    Message message,
    String contactId,
  );
  Stream<List<Message>> getMessages(
    String userId,
    String contactId,
  );
}
